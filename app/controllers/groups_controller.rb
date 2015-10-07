class GroupsController < ApplicationController
  before_action :correct_user,   only: [:edit, :update, :show, :delete]
  before_action :logged_in_user
  
  def new
    @group = Group.new
  end
  
  def create
    @group = current_user.groups.create(group_params)
    if @group.valid?
      flash[:success] = "Successfully created inv"
      redirect_to new_inv_path
    else
      flash.now[:danger] = 'something went wrong'
      render new_invs_path
    end
  end
  
  def index
    @groups = Group.all.where(user_id: current_user.id).reverse
  end
  
  def show
    @group = Group.find(params[:id])
    @invs = @group.invs.all
  end
  
  def download
    @group = Group.find(params[:id])
    makepdfgroup(@group)
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
