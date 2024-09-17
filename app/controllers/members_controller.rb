class MembersController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @member = Member.new
    @member.user = current_user
    @member.group = @group

    if @member.save
      # Assign existing punishments and rewards to the new member
      @group.punishments.each do |punishment|
        @member.member_punishments.create(punishment: punishment)
      end

      @group.rewards.each do |reward|
        @member.member_rewards.create(reward: reward)
      end
      ### Crea un progreso asignado al nuevo miembro para cada task en el grupo
      @group.tasks.each do |task|
        progress = Progress.new(task_id: task.id, member_id: @member.id, completion: 0.00)
        progress.save
      end
      redirect_to group_path(@group)
    else
      render "groups/show", status: :unprocessable_entity
    end
  end

  def index
    @members = Member.where(group_id: params[:group_id])
    @group = @members.first.group
    @tasks = Task.where(group_id: params[:group_id])
    ranking_calculation = RankingCalculation.new(@tasks, params[:group_id])
    @progress = ranking_calculation.progress
    @sorted_positions = ranking_calculation.position_table
    @member_punishments = current_user.members.find_by(group_id: params[:group_id]).member_punishments.includes(:punishment)
    @member_rewards = current_user.members.find_by(group_id: params[:group_id]).member_rewards.includes(:reward)
  end

  def show
    @user = User.find(current_user.id)
    @tasks = @user.tasks
  end

  def destroy
    # 1. Delete the member
    @member = Member.find(params[:id])
    group = @member.group
    is_current_user = @member.user_id == current_user.id
    # 2. Delete the  member along their progresse because it have dependen destroy
    @member.destroy
    # 3. Redireccionar a la misma vista
    if is_current_user
      redirect_to groups_path
    else
      redirect_to group_members_path(group)
    end
  end
end
