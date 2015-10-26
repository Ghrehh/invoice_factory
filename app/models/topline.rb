class Topline < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :value, presence: true
  default_scope { order("position ASC") }
end
