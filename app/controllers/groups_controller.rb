class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_groups = RankingCalculation.group_with_avances(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @members = Member.where(group: @group)
    @users = User.joins(:members).where(members: { group_id: @group })
    # @tasks = Task.where(group: @group)
    @tasks = @group.tasks if @group.tasks.present?
    @task = Task.new
    @reward = Reward.new
    @punishment = Punishment.new
    # For progresses, we're going to find each progress in the view directly
  end

  def new
    @group = Group.new
    @task = Task.new
    @group.tasks.build if @group.tasks.empty?
    @group.rewards.build if @group.rewards.empty?
    @group.punishments.build if @group.punishments.empty?
    @group.members.build if @group.members.empty?
  end

  def create
    @group = Group.new(group_params)
    @user = current_user
    if @group.save
      @admin = Member.new(user_id: @user.id, group_id: @group.id, admin: true)
      @admin.save

      ### Creating Progress instances with 0% completion at the initialization of the group ###
      @tasks = Task.where(group: @group)
      @members = Member.where(group: @group)
      @tasks.each do |task|
        @members.each do |member|
          progress = Progress.new(task_id: task.id, member_id: member.id, completion: 0.00)
          progress.save
        end
      end

      redirect_to group_path(@group.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def edit
    @group = Group.find(params[:id])
    @group.tasks.build if @group.tasks.empty?
    @group.rewards.build if @group.rewards.empty?
    @group.punishments.build if @group.punishments.empty?
    @group.members.build if @group.members.empty?
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:name,
                                  tasks_attributes:[:id, :name, :unit, :quantity, :_destroy],
                                  punishments_attributes: [:id, :name, :_destroy],
                                  rewards_attributes: [:id, :name, :_destroy])
  end
end
