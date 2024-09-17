class MemberRewardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member_reward, only: [:update]

  def index
    @member_rewards = current_user.members.find_by(group_id: params[:group_id]).member_rewards.includes(:reward)
  end

  def update
    if @member_reward.update(status: 'claimed')
      redirect_to group_members_path(@member_reward.member.group), notice: 'Reward claimed successfully.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_member_reward
    @member_reward = MemberReward.find(params[:id])
  end
end
