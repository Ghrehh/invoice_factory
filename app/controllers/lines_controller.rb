class LinesController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :delete]
  before_action :logged_in_user
  
  
  
  def create
    @inv = Inv.find(params[:inv_id])
    @invs = Inv.all.where(user_id: current_user.id).reverse 
   
    
    @line = @inv.lines.new(line_params)
    @line.position = @inv.lines.count + 1
    @lines = @inv.lines.all
    
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
    
     @total = get_total(@inv)
  
    if @line.save
      flash.now[:success] = "Invoice Saved"
    else
      flash.now[:danger] = "Line wasn't created properly, ensure the description field contains something"
    end
    
    
  end
  
  def edit
    @line = Line.find(params[:id])
    
    @inv = @line.inv
    @lines = @inv.lines.all
    @total = get_total(@inv)
  end
  
  
  def update
    @line = Line.find(params[:id]) 
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user

    if @line.update_attributes(line_params)
      flash.now[:success] = "Invoice Saved"
    else
      flash.now[:danger] = "Line wasn't updated, ensure the description field contains something"
    end
    
    @inv = @line.inv
    @lines = @inv.lines.all
    @total = get_total(@inv)
  end
  
  def order
    params[:order].each_with_index do |post_id, i|
	    Line.find_by(id: post_id).update_attribute(:position, i + 1)
    end
    render :nothing => true
  end
  
  
  
  def destroy
    @line = Line.find(params[:id])
    
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
    
    @inv = @line.inv
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    
    
    @lines = @line.inv.lines.all
    @line.destroy
    
    @total = get_total(@inv)
    

    
   
    flash.now[:danger] = "Deleted Line"
  end
  
  
  
  private

  def line_params
    params.require(:line).permit(:service, :description, :price, :quantity)
  end
  
  def correct_user
    @user = Line.find(params[:id]).inv.user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
end
