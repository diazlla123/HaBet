class MembersController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @member = Member.new
    @member.user = current_user
    @member.group = @group

    if @member.save
      redirect_to group_path(@group)
    else
      render "groups/show", status: :unprocessable_entity
    end
  end

  def index
    @member = Member.where(group_id: params[:group_id])
    @tasks = Task.where(group_id: params[:group_id])
    ranking_calculation = RankingCalculation.new(@tasks, params[:group_id])
    @progress = ranking_calculation.progress
    @sorted_positions = ranking_calculation.position_table

  end

  def show
    @user = User.find(current_user.id)
    @tasks = Task.joins(group: :members).where(members: { user_id: current_user.id })
  end
end
