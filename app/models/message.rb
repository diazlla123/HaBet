class Message < ApplicationRecord
  belongs_to :member
  belongs_to :group

  validates :content, :group_id, :member_id, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "group_#{group.id}_messages",
                        partial: "messages/message",
                        locals: { message:self }
  end
end
