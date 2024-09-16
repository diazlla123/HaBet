class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @messages = Message.where(group_id: @group.id)
    @message = Message.new(group_id: @group.id)
  end

  def create
    @group = Group.find(params[:group_id])
    @member = Member.find_by(group_id: @group.id, user_id: current_user.id)
    @new_message = Message.new(content: params[:message][:content], group_id: @group.id, member_id: @member.id)
    if @new_message.save!
      redirect_to group_messages_path(@group.id)
    else
      render "groups/index", status: :unprocessable_entity
    end
  end
end
