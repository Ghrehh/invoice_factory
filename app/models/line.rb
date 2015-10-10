class Line < ActiveRecord::Base
  belongs_to :inv
  
  default_scope { order("position ASC") }
end
