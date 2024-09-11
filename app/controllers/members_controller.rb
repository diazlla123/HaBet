class MembersController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @member = Member.new
    @member.user = current_user
    @member.group = @group
    
    if @member.save
      redirect_to group_path(@group)
    else
      render "groups/show", status: :unprocessable_entity
    end
  end
end
