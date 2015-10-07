class GroupsController < ApplicationController
  def change_group
    @group = Inv.find(params[:id])
    current_user.current_group = @group
  end
end
