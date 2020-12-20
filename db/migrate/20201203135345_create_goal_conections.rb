class CreateGoalConections < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_conections, :force => true, id: false do |t|
      t.belongs_to :goal

    end
  end
end
