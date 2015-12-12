class GroupsController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :delete, :download]
  before_action :logged_in_user
  
  def new
    @group = Group.new
    
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @groups = Group.all.where(user_id: current_user.id).reverse
    
  end
  
  
  def create
    @group = current_user.groups.create(group_params)
    
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @groups = Group.all.where(user_id: current_user.id).reverse
    
  
    
    if @group.valid?
      flash.now[:success] = "Successfully created group"
      @invs = Inv.all.where(user_id: current_user.id).reverse
      @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
      redirect_to new_group_path

    else
      flash.now[:danger] = 'something went wrong'
    end
    
  end
  
  
  def index
    @groups = Group.all.where(user_id: current_user.id).reverse
  end
  
  
  def show
    @group = Group.find(params[:id])
    @groups = Group.all.where(user_id: current_user.id).reverse
    @groupinvs = @group.invs.all
    @invs = Inv.all.where(user_id: current_user.id).reverse 
  end
  
  
  def download
    @group = Group.find(params[:id])
    makepdfgroup(@group)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.invs.each do |inv| 
      inv.group_id = nil
      inv.save
    end
    @group.destroy
    
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @groups = Group.all.where(user_id: current_user.id).reverse
    
  end
  
  private

  def group_params
    params.require(:group).permit(:name)
  end
  
  
  def correct_user
    @user = Group.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end

  
end
