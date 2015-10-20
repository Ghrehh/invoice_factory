class StaticPagesController < ApplicationController
  before_action :logged_in_user
  
  def dashboard
    @invs = Inv.all.where(user_id: current_user.id).reverse
  end
end
