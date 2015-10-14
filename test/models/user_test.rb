require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "bob", password: "bob2", password_confirmation: "bob2")
  end
  
  test "user should be valid" do
    assert @user.valid?
  end
  
  
end
