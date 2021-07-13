class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, presence: true
      t.datetime :start_time, presence: true
      t.datetime :end_time, presence: true
      t.string :description
      t.integer :color, null: false, default: 0
      t.boolean :allday, null: false, default: false
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
