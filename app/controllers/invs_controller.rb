require "prawn"
require "fileutils"

class InvsController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :download, :delete]
  before_action :logged_in_user
  
  def new
    @inv = Inv.new
    @group = Group.all.where(user_id: current_user.id).reverse
  end
  
  
  def download
    @inv = Inv.find(params[:id])
    makepdf(@inv)
  end
  
  
  def show
    @inv = Inv.find(params[:id])
  end
  
  
  
  def edit
    @inv = Inv.find(params[:id])
    @lines = @inv.lines.all
    @line = @inv.lines.new
    
    @total = 0
    @inv.lines.each do |x|
      if x.price != nil
        @total += x.price
      end
    end
    
  end
  
  
  
  def index
    @invs = Inv.all.where(user_id: current_user.id) 
  end
  
  
  
  def update
    
    @inv = Inv.find(params[:id])
    if @inv.update_attributes(inv_params)
      redirect_to edit_inv_path(@inv.id)
    else
      render 'edit'
    end
    
  end



  def create
    @inv = current_user.invs.create(inv_params)
    if @inv.valid?
      flash[:success] = "Successfully created inv"
      redirect_to edit_inv_path(@inv.id)
    else
      flash.now[:danger] = 'something went wrong'
      render new_invs_path
    end
  end
  
  
  
  def destroy
    @inv = Inv.find(params[:id])
    @inv.destroy
    redirect_to(:root)
  end
  
  
  
  
  private

  def inv_params
    params.require(:inv).permit(:recipient, :group_id)
  end
  
  def correct_user
    @user = Inv.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end

  
end
