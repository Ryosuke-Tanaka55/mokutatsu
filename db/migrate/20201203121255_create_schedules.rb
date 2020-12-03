class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.date :worked_on
      t.string :goal
      t.date :deadline
      t.string :goal_index
      t.integer :achivement
      t.text :check
      t.text :adjust
      t.integer :progress
      t.boolean :hold, default: false, null: false
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
