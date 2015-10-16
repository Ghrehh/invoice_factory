class CoverimagesController < ApplicationController
  
  def show
    @coverimage = Coverimage.find(params[:id])
        send_data(@coverimage.file_contents,
                :filename => @coverimage.filename,
                :type => @coverimage.content_type,
                :disposition => "inline")
  end
  
  def new
    @coverimage = Coverimage.new
  end
  
  def create
    @coverimage = current_user.coverimages.new(coverimages_params)
    if current_user.coverimages.count < 1
      @coverimage.save
    else
      flash[:danger] ="already have a picture"
    end
      redirect_to edit_user_path(current_user.id)
  end
  
  def update
    @coverimage = Coverimage.find(params[:id]) 
    @coverimage2 = current_user.coverimages.new(coverimages_params)
    if @coverimage2.save
      @coverimage.delete
      flash.now[:success] = "Picture updated successfully"
    else
      flash.now[:danger] = "Oops, something went wrong! Did you leave the name field blank?"
    end
    
    redirect_to edit_user_path(current_user.id)
  end
  
  
  private
  def coverimages_params
    params.require(:coverimage).permit(:file)
  end
end
