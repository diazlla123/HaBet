class MemberPunishmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member_punishment, only: [:update]

  def index
    @member_punishments = current_user.members.find_by(group_id: params[:group_id]).member_punishments.includes(:punishment)
  end

  def update
    if @member_punishment.update(status: 'completed')
      redirect_to group_members_path(@member_punishment.member.group), notice: 'Punishment marked as completed.'
    else
      redirect_to group_members_path(@member_punishment.member.group), alert: 'Unable to update punishment.'
    end
  end

  private

  def set_member_punishment
    @member_punishment = MemberPunishment.find(params[:id])
  end
end
