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

ActiveRecord::Schema.define(version: 2020_12_24_100456) do

  create_table "doings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "doing"
    t.datetime "start_day"
    t.datetime "finish_day"
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "type", default: false, null: false
    t.integer "priority"
    t.integer "impact"
    t.integer "worktime"
    t.integer "easy"
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_doings_on_user_id"
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

  create_table "goals_subgoals", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "goal_id"
    t.bigint "subgoal_id"
    t.index ["goal_id"], name: "index_goals_subgoals_on_goal_id"
    t.index ["subgoal_id"], name: "index_goals_subgoals_on_subgoal_id"
  end

  create_table "subgoals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subgoal"
    t.date "start_day"
    t.date "finish_day"
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "type", default: false, null: false
    t.text "gap"
    t.text "solution"
    t.integer "priority", default: 0, null: false
    t.integer "impact", default: 0, null: false
    t.integer "worktime", default: 0, null: false
    t.integer "easy", default: 0, null: false
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "user_id"
    t.bigint "goal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_subgoals_on_goal_id"
    t.index ["user_id"], name: "index_subgoals_on_user_id"
  end

  create_table "todos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "todo"
    t.date "start_day"
    t.date "finish_day"
    t.time "estimated_time"
    t.datetime "estimated_start_time"
    t.datetime "estimated_finish_time"
    t.datetime "actual_start_time"
    t.datetime "actual_finish_time"
    t.integer "achivement"
    t.text "check"
    t.text "adjust"
    t.boolean "type", default: false, null: false
    t.integer "progress", default: 0, null: false
    t.boolean "hold", default: false, null: false
    t.text "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
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

  add_foreign_key "doings", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "subgoals", "goals"
  add_foreign_key "subgoals", "users"
  add_foreign_key "todos", "users"
end
