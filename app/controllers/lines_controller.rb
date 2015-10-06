class LinesController < ApplicationController
  
  
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
  
  
end
