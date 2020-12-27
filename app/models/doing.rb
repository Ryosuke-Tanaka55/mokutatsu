class Doing < ApplicationRecord
  belongs_to :subgoal
  has_many :todoes, dependent: :destroy
  accepts_nested_attributes_for :todoes
end
