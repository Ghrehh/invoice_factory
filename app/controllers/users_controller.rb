class UsersController < ApplicationController
  
  before_action :correct_user,   only: [:edit, :update, :show, :download, :delete]
  before_action :logged_in_user
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id]) 
    @user.update_attributes(user_params)
    redirect_to edit_user_path(@user.id)
  end
  
  
  
  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
end
