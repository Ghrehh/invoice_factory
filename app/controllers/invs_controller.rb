require "prawn"

class InvsController < ApplicationController
  
  def new
    @inv = Inv.new
  end
  
  def download
    @inv = Inv.find(params[:id])
    makepdf(@inv)
  end
  
  
  def show
    @inv = Inv.find(params[:id])
    #im guessing I won't need to make a var for the lines as i'll be appending them all with js if it's a new invoice
  end
  
  
  
  def edit
    @inv = Inv.find(params[:id])
    @lines = @inv.lines.all
  end
  
  
  
  def index
    @inv = Inv.all
  end
  
  
  
  def update
    @inv = Inv.find(params[:id])
    if @inv.update_attributes(inv_params)
      flash[:success] = "inv updated"
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
    params.require(:inv).permit(:recipient)
  end

  
end
