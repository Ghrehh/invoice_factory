class User < ActiveRecord::Base
  has_secure_password
  
  has_many :invs
  has_many :groups
  has_many :blocks
end
