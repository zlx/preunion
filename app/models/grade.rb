class Grade < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, :weights, presence: true
end
