class Inv < ActiveRecord::Base
  belongs_to :user
  has_many :lines
  has_one :block
  belongs_to :group
end
