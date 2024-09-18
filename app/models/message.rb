class Message < ApplicationRecord
  belongs_to :member
  belongs_to :chat

  validates :content, :chat_id, :member_id, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "chat_#{chat.id}_messages",
                        partial: "messages/message",
                        locals: { message: self, current_user_id: member.id }
  end
end
