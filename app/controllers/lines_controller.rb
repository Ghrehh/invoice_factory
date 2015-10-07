class LinesController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :delete]
  before_action :logged_in_user
  
  
  
  def create
    @inv = Inv.find(params[:inv_id])
    @line = @inv.lines.new(line_params)
    @lines = @inv.lines.all
    
    @total = 0
    @inv.lines.each do |x|
      if x.price != nil
        @total += x.price
      end
    end
    
    if @line.save
      
       
    else
      flash.now[:danger] = 'Your comment must contain a body!'
    end
    
  end
  
  
  
  def destroy
    @line = Line.find(params[:id])
    @lines = @line.inv.lines.all
    @line.destroy
    @inv = @line.inv
    
    @total = 0
    @inv.lines.each do |x|
      if x.price != nil
        @total += x.price
      end
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
