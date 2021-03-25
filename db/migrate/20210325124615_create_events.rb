class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :memo
      t.references :user, null: false, foreign_key: true
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
