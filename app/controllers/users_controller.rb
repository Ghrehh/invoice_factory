class UsersController < ApplicationController
  
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :logged_in_user, only: [:edit, :update, :tutorial_1, :tutorial_3]
  
  def new
    redirect_to root_url if logged_in?
    @user = User.new
  end
  
  def create
    
    @user = User.create(user_params)
    
    if @user.valid?
      @user.toplines.create(name: "ADDRESS", value: "Your Address")
      @user.toplines.create(name: "MOBILE", value: "Your Mobile/Cell")
      @user.toplines.create(name: "PHONE", value: "Your Phone")
      @user.toplines.create(name: "EMAIL", value: "Your Email")
      
      @user.invs.create(recipient: "Test Recipient", address_1: "26 Test Street, \n Test City")
      log_in @user
      redirect_to root_url
      
    else
      flash[:danger] = "Invalid username/password"
      redirect_to new_user_path
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
    #@user.invs.create(recipient: "TestInvoice%/////%%///%%//%%//%%//") if @user.invs.count == 0 #creates an invoice for the user if they have none on the edit page
    
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @toplines = current_user.toplines.all

  end
  
  def update
    @user = User.find(params[:id]) 
    
    @invs = Inv.all.where(user_id: current_user.id).reverse
      
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    @toplines = current_user.toplines.all
      
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully Updated"
    else
      flash[:danger] = "Oops, something went wrong"
    end
    
  end
  
  def tutorial_1
    @user = current_user
    @user.sender = params[:data]
    @user.save
    @toplines = current_user.toplines.all
  end
  
  def tutorial_3
    @user = current_user
    @user.topoffset = params[:data]
    @user.save
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email, :invoice_email, :address, :phone, :mobile, :topoffset, :sender, :use_picture)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
