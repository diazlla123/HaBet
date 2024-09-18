module ApplicationHelper
  def unread_message_count
    unread_messages = 0
    if current_user
      members = Member.where(user_id: current_user.id)
      if members
        members.each do |member|
          unread_messages += Read.where(member_id: member.id, read: false).count
        end
      end
    end
    return unread_messages unless unread_messages.zero?
  end
end
