class CreateGoalConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_connections do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :goal_connections, :parent_id
    add_index :goal_connections, :child_id
    add_index :goal_connections, [:parent_id, :child_id], unique: true
  end
end
