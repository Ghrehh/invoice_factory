class Inv < ActiveRecord::Base
  belongs_to :user
  has_many :lines
end
