class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.date :worked_on
      t.string :goal, presence: true
      t.string :tag
      t.date :start_day, presence: true
      t.date :finish_day, presence: true
      t.string :goal_index, presence: true
      t.integer :achivement, null: false, default: 0
      t.text :check
      t.text :adjust
      t.integer :progress, null: false, default: 0
      t.boolean :hold, null: false, default: false
      t.integer :publish, null: false, default: 0
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
