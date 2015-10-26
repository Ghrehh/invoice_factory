class InvsController < ApplicationController
  respond_to :html, :js
  
  before_action :correct_user,   only: [:edit, :update, :show, :download, :delete]
  before_action :logged_in_user
    skip_before_filter :verify_authenticity_token, :only => [:show]
  
  
  def new #Dont actually need this
    @inv = Inv.new
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
    
      @invs = Inv.all.where(user_id: current_user.id).reverse 
      @lines = @inv.lines.all
      @line = @inv.lines.new

      @total = get_total(@inv)
  end
  
  
  def edit #don't think i need this
    @inv = Inv.find(params[:id])
    @lines = @inv.lines.all
    @line = @inv.lines.new
    
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
    
    @total = get_total(@inv)
  end
  
  
  
  
  
  def download #Actual download link
    @inv = Inv.find(params[:id])
    makepdf(@inv)
  end
  
  def show #just displays the pdf, hence the true param
    @inv = Inv.find(params[:id])
    makepdf(@inv, true)
  end
  
  

  
  def update
    @inv = Inv.find(params[:id]) 
    if @inv.update_attributes(inv_params)
      flash.now[:success] = "Invoice Saved"
      
      @invs = Inv.all.where(user_id: current_user.id).reverse 
      @lines = @inv.lines.all
      @line = @inv.lines.new
      @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
      @total = get_total(@inv)
      
    else
      unless @inv.total.is_a? Integer
        flash.now[:danger] = "A total must be a number"
      else
        flash.now[:danger] = "Oops, something went wrong! Did you leave the name field blank?"
      end
    end
    
  end
  
  
  def index
    @invs = Inv.all.where(user_id: current_user.id) 
  end


  def create
    @inv = current_user.invs.create(inv_params) #the invoice being created
    @invs = Inv.all.where(user_id: current_user.id).reverse #invoices for the search bar
    
    if @inv.valid?
      
        
      @lines = @inv.lines.all
      @line = @inv.lines.new
      @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
      @total = get_total(@inv)
      
    else
      flash.now[:danger] = 'something went wrong, ensure you provided a recipient'
      
    end
  end
  
  
  
  def destroy
    @inv = Inv.find(params[:id])
    @inv.destroy
    @total = get_total(@inv)
  end
  
  
  def search
    @invs = Inv.all.where("recipient like ? ", "%#{params[:search]}%").where(user_id: current_user.id).reverse
  end
  
  def dashboard_invoice #displays the clicked invoice on the dashboard
    @inv = Inv.find(params[:id])
    @invs = Inv.all.where(user_id: current_user.id).reverse 
    @lines = @inv.lines.all
    @line = @inv.lines.new
    @group = Group.all.where(user_id: current_user.id).reverse #finds all groups created by current user
    @total = get_total(@inv)
  end
  
  
  
  def recipient_form #method to display the name change form on click
    @inv = Inv.find(params[:id])
  end
  
  def total_form
    @inv = Inv.find(params[:id])
    @total = get_total(@inv)
  end
  
  
  private

  def inv_params
    params.require(:inv).permit(:recipient, :group_id, :total, :block, :address_1, :address_2, :address_3, :date, :due_date, :note)
  end
  
  def correct_user
    @user = Inv.find(params[:id]).user
    redirect_to(root_url) unless current_user?(@user)
  end

  
end
