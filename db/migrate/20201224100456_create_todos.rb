class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :todo, presence: true
      t.date :worked_on, presence: true
      t.date :start_day, presence: true
      t.date :finish_day, presence: true
      t.time :estimated_time, presence: true
      t.time :estimated_start_time, presence: true
      t.time :estimated_finish_time, presence: true
      t.datetime :actual_start_time
      t.datetime :actual_finish_time
      t.integer :priority, null: false, default: 0
      t.integer :achivement
      t.text :check
      t.text :adjust
      t.boolean :pattern, null: false, default: false
      t.integer :progress, null: false, default: 0
      t.boolean :hold, null: false, default: false
      t.text :note

      t.references :user, null: false, foreign_key: true
      t.references :doing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
