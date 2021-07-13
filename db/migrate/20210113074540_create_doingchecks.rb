class CreateDoingchecks < ActiveRecord::Migration[6.0]
  def change
    create_table :doingchecks do |t|
      t.text :check
      t.text :adjust
      t.datetime :estimate_check_at, presence: true
      t.datetime :check_at
      t.string :span, presence: true
      t.integer :achivement
      t.string :note
      t.references :doing, null: false, foreign_key: true

      t.timestamps

    end
  end
end
