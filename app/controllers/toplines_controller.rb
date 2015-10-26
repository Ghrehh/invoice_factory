class ToplinesController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :delete]
  before_action :logged_in_user
  
  
  
  def create
   
    @topline = current_user.toplines.new(topline_params)
    @topline.position = current_user.toplines.count + 1
    
    @user = current_user
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    @toplines = current_user.toplines.all
    
    @invs = Inv.all.where(user_id: current_user.id).reverse
    
  
    if @topline.save
      flash.now[:success] = "Line Saved"
    else
      flash.now[:danger] = "topline wasn't created properly, ensure the description field contains something"
    end
    
    
  end
  
  def edit
    @topline = Topline.find(params[:id])
    
    @user = current_user
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    @toplines = current_user.toplines.all
    
    @invs = Inv.all.where(user_id: current_user.id).reverse
  end
  
  
  def update
    @topline = Topline.find(params[:id])
    
    @user = current_user
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    @toplines = current_user.toplines.all
    
    @invs = Inv.all.where(user_id: current_user.id).reverse

    if @topline.update_attributes(topline_params)
      flash.now[:success] = "Invoice Saved"
    else
      flash.now[:danger] = "topline wasn't updated, ensure the description field contains something"
    end
    
  end
  
  def order
    params[:order].each_with_index do |post_id, i|
	    Topline.find_by(id: post_id).update_attribute(:position, i + 1)
    end
    render :nothing => true
  end
  
  
  
  def destroy
    @topline = Topline.find(params[:id])
    @topline.destroy
    
    @user = current_user
    @coverimage = @user.coverimages.first
    @previewinv = @user.invs.first
    @toplines = current_user.toplines.all
    
    @invs = Inv.all.where(user_id: current_user.id).reverse
    

    
   
    flash.now[:danger] = "Deleted topline"
  end
  
  
  
  private

  def topline_params
    params.require(:topline).permit(:name, :value)
  end
  
  def correct_user
    @user = Topline.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
end


