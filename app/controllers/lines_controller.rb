class LinesController < ApplicationController
  before_action :correct_user,   only: [:edit, :update, :show, :download]
  before_action :logged_in_user
  
  
  def create
    @inv = Inv.find(params[:inv_id])
    @line = @inv.lines.new(line_params)
    
    if @line.save
      flash[:success] = "Successfully created Comment!"
    else
      flash.now[:danger] = 'Your comment must contain a body!'
    end
    
  end
  
  
  private

  def line_params
    params.require(:line).permit(:service, :description, :price)
  end
  
  def correct_user
    @user = Line.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
end
