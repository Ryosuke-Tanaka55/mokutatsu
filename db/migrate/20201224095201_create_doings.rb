class CreateDoings < ActiveRecord::Migration[6.0]
  def change
    create_table :doings do |t|
      t.string :doing, presence: true
      t.date :start_day, presence: true
      t.date :finish_day, presence: true
      t.boolean :pattern, null: false, default: false
      t.integer :priority, presence: true
      t.integer :impact, presence: true
      t.integer :worktime, presence: true
      t.integer :easy, presence: true
      t.integer :progress, null: false, default: 0
      t.boolean :hold, null: false, default: false
      t.string :note
      t.references :subgoal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
