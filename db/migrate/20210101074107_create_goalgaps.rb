class CreateGoalgaps < ActiveRecord::Migration[6.0]
  def change
    create_table :goalgaps do |t|
      t.string :gap, presence: true
      t.text :detail, presence: true
      t.text :solution, presence: true
      t.integer :impact, null: false, default: 0
      t.integer :worktime, null: false, default: 0
      t.integer :easy, null: false, default: 0
      t.integer :priority, null: false, default: 0
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
