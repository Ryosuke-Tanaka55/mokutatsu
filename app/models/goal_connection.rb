class GoalConnection < ApplicationRecord
  belongs_to :parent, class_name: 'Goal'
  belongs_to :child, class_name: 'Goal'
end
