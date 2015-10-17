class CoverimagesController < ApplicationController
  
  before_action :correct_user,   only: [:edit, :update, :show, :download, :delete]
  before_action :logged_in_user
  
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
      write_to_tree(@coverimage) #creates a image file in the tree
      
    else
      flash[:danger] ="already have a picture"
    end
      redirect_to edit_user_path(current_user.id)
  end
  
  def update
    @coverimage = Coverimage.find(params[:id]) 
    @coverimage2 = current_user.coverimages.new(coverimages_params)
    
    if @coverimage2.save
      
      delete_image(@coverimage) #deletes the previous image from the tree
      @coverimage.delete #then deletes it from the db
      
      write_to_tree(@coverimage2) #and writes the new one
      
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
  
  def correct_user
    @user = Coverimage.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end
  
end
