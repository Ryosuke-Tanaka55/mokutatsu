class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :goal, presence: true
      t.integer :category, presence: true
      t.date :start_day, presence: true
      t.date :finish_day, presence: true
      t.string :goal_index, presence: true
      t.integer :progress, null: false, default: 0
      t.boolean :hold, null: false, default: false
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
  end
end
