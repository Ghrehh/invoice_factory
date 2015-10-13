class Line < ActiveRecord::Base
  belongs_to :inv
  
  validates :description, presence: true
  default_scope { order("position ASC") }
end
