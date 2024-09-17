class ChatsController < ApplicationController
  def index
    @groups = Group.joins(:members).where(members: { user_id: current_user.id })
  end

  def show
    @chat = Chat.find(params[:chat_id])
    @messages = Message.where(group_id: @chat.group_id)
    @message = Message.new(group_id: @chat.group_id)
  end
end
