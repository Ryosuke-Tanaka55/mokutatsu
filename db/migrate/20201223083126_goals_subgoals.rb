class GoalsSubgoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals_subgoals, id: false do |t|
      t.belongs_to :goal
      t.belongs_to :subgoal
    end
  end
end
