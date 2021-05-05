class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :color, null: false
      t.boolean :allday, null: false, default: false
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
