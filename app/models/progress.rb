class Progress < ApplicationRecord
  belongs_to :task
  belongs_to :member

  # Broadcast for members ranking
  after_create_commit :broadcast_ranking
  after_update_commit :broadcast_ranking

  # Broadcast for incentives
  after_create_commit :broadcast_incentives
  after_update_commit :broadcast_incentives

  def member_punishments
    member.member_punishments.includes(:punishment)
  end

  def member_rewards
    member.member_rewards.includes(:reward)
  end

  private

  def broadcast_ranking
    broadcast_update_to "group_#{member.group.id}_rank",
                        target: "group_ranking",
                        partial: "members/member_rank",
                        locals: { sorted_positions: member.sorted_positions, member_user: member.user, group_id: member.group.id }
  end

  def broadcast_incentives
    broadcast_update_to "group_#{member.group.id}_incentives",
                        target: "member_incentives",
                        partial: "members/incentives",
                        locals: { member_punishments: member_punishments, member_rewards: member_rewards, group: member.group }
  end

end
