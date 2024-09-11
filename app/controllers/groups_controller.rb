class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_groups = Group.joins(:members).where(members: { user_id: current_user})

  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @group.tasks.build if @group.tasks.empty?
    @group.rewards.build if @group.rewards.empty?
    @group.punishments.build if @group.punishments.empty?
    @group.members.build if @group.members.empty?
  end

  def create
    @group = Group.new(group_params)
    @user = current_user
    if @group.save!
      @admin = Member.new(user_id: @user.id, group_id: @group.id, admin: true)
      @admin.save
      redirect_to @group, notice: "ESSOOO"
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
  end

  def edit
  end

  def update
  end

  private

  def group_params
    params.require(:group).permit(:name,
                                  tasks_attributes:[:id, :name, :unit, :quantity, :_destroy],
                                  punishments_attributes: [:id, :name, :_destroy],
                                  rewards_attributes: [:id, :name, :_destroy])
  end
end
