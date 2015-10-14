class UsersController < ApplicationController
  
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :logged_in_user, only: [:edit, :update]
  
  def new
    redirect_to root_url if logged_in?
    @user = User.new
  end
  
  def create
    
    @user = User.create(user_params)
    
    if @user.valid?
      log_in @user
      flash[:success] = "Successfully Logged In"
      redirect_to root_url
      
    else
      flash[:danger] = "Invalid username/password"
      redirect_to new_user_path
    end
    
  end
  
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
