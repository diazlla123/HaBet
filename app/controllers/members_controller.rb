class MembersController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @member = Member.new
    @member.user = current_user
    @member.group = @group

    if @member.save
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
  end

  def show
    @user = User.find(current_user.id)
    @tasks = Task.joins(group: :members).where(members: { user_id: current_user.id })
  end

  def destroy
    # 1. Delete the member
    @member = Member.find(params[:id])
    group = @member.group

    # 2. Delete the  member along their progresse because it have dependen destroy
    @member.destroy
    # 3. Redireccionar a la misma vista
    redirect_to group_members_path(group)
  end
end
