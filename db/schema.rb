# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_19_003658) do

  create_table "doingchecks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "check"
    t.text "adjust"
    t.datetime "estimate_check_at"
    t.datetime "check_at"
    t.date "span"
    t.integer "achivement"
    t.string "note"
    t.bigint "doing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doing_id"], name: "index_doingchecks_on_doing_id"
  end

  create_table "doings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "doing"
    t.datetime "start_day"
    t.datetime "finish_day"
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "pattern", default: false, null: false
    t.integer "priority"
    t.integer "impact"
    t.integer "worktime"
    t.integer "easy"
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "subgoal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subgoal_id"], name: "index_doings_on_subgoal_id"
  end

  create_table "goal_connections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_goal_connections_on_child_id"
    t.index ["parent_id", "child_id"], name: "index_goal_connections_on_parent_id_and_child_id", unique: true
    t.index ["parent_id"], name: "index_goal_connections_on_parent_id"
  end

  create_table "goalchecks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "check"
    t.text "adjust"
    t.datetime "estimate_check_at"
    t.datetime "check_at"
    t.date "span"
    t.integer "achivement"
    t.string "note"
    t.bigint "goal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_goalchecks_on_goal_id"
  end

  create_table "goalgaps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "gap"
    t.text "detail"
    t.text "solution"
    t.integer "impact", default: 0, null: false
    t.integer "worktime", default: 0, null: false
    t.integer "easy", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.bigint "goal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_goalgaps_on_goal_id"
  end

  create_table "goals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "worked_on"
    t.string "goal"
    t.string "category"
    t.date "start_day"
    t.date "finish_day"
    t.string "goal_index"
    t.integer "achivement", default: 0, null: false
    t.text "check"
    t.text "adjust"
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.integer "publish", default: 0, null: false
    t.text "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.string "image_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  end

  create_table "subgoalchecks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "check"
    t.text "adjust"
    t.datetime "estimate_check_at"
    t.datetime "check_at"
    t.date "span"
    t.integer "achivement"
    t.string "note"
    t.bigint "subgoal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subgoal_id"], name: "index_subgoalchecks_on_subgoal_id"
  end

  create_table "subgoalgaps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "gap"
    t.text "detail"
    t.text "solution"
    t.integer "impact", default: 0, null: false
    t.string "term"
    t.integer "worktime", default: 0, null: false
    t.integer "easy", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.bigint "subgoal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subgoal_id"], name: "index_subgoalgaps_on_subgoal_id"
  end

  create_table "subgoals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subgoal"
    t.boolean "important", default: false, null: false
    t.date "start_day"
    t.date "finish_day"
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "pattern", default: false, null: false
    t.integer "priority", default: 0, null: false
    t.integer "impact", default: 0, null: false
    t.integer "worktime", default: 0, null: false
    t.integer "easy", default: 0, null: false
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "goal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_subgoals_on_goal_id"
  end

  create_table "todos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "todo"
    t.date "worked_on"
    t.date "start_day"
    t.date "finish_day"
    t.time "estimated_time"
    t.time "estimated_start_time"
    t.time "estimated_finish_time"
    t.datetime "actual_start_time"
    t.datetime "actual_finish_time"
    t.integer "priority", default: 0, null: false
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "pattern", default: false, null: false
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "doing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doing_id"], name: "index_todos_on_doing_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.string "image"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "agreement", default: false, null: false
    t.boolean "anonymous", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "doingchecks", "doings"
  add_foreign_key "doings", "subgoals"
  add_foreign_key "goalchecks", "goals"
  add_foreign_key "goalgaps", "goals"
  add_foreign_key "goals", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "subgoalchecks", "subgoals"
  add_foreign_key "subgoalgaps", "subgoals"
  add_foreign_key "subgoals", "goals"
  add_foreign_key "todos", "doings"
end
