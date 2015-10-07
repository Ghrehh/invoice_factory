class Group < ActiveRecord::Base
  has_many :invs
  belongs_to :user
end
