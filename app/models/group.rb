class Group < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :invs
  belongs_to :user
end
