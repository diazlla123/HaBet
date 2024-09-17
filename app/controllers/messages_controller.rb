class MessagesController < ApplicationController
  def index
    @chat = Chat.find(params[:chat_id])
    @messages = Message.where(chat_id: @chat.id)
    @message = Message.new(chat_id: @chat.id)
  end

  # def show
  #   @group = Group.find(params[:group_id])
  #   @messages = Message.where(group_id: @group.id)
  #   @message = Message.new(group_id: @group.id)
  # end

  def create
    # @group = Group.find(params[:group_id])
    @chat = Chat.find(params[:chat_id])
    @member = Member.find_by(group_id: @chat.group_id, user_id: current_user.id)
    @new_message = Message.new(content: params[:message][:content], chat_id: @chat.id, member_id: @member.id)
    if @new_message.save!
      redirect_to chat_messages_path(@chat.id)
    else
      render "groups/index", status: :unprocessable_entity
    end
  end
end
