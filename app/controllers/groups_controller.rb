class GroupsController < ApplicationController
  def index
    @user_groups = Group.joins(:members).where(members: { user_id: current_user})
  end
end
