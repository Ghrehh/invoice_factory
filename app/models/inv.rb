class Inv < ActiveRecord::Base
  belongs_to :user
  has_many :lines
  belongs_to :group
end
