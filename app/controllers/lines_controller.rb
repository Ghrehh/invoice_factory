class LinesController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :delete]
  before_action :logged_in_user
  
  
  
  def create
    @inv = Inv.find(params[:inv_id])
    @lines = @inv.lines.all
    
    @total = get_total(@inv)
    
    @line = @inv.lines.new(line_params)
    @line.position = @inv.lines.count + 1
    @line.save
  end
  
  def edit
    @line = Line.find(params[:id])
    
    @inv = @line.inv
    @lines = @inv.lines.all
    @total = get_total(@inv)
  end
  
  
  def update
    @line = Line.find(params[:id]) 
    @line.update_attributes(line_params)
    
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
    @lines = @line.inv.lines.all
    @line.destroy
    @inv = @line.inv
    
    @total = get_total(@inv)
  end
  
  
  
  private

  def line_params
    params.require(:line).permit(:service, :description, :price)
  end
  
  def correct_user
    @user = Line.find(params[:id]).inv.user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
end
