class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @group = params[:task][:group_id]
    @task = Task.new(task_params)
    if @task.save
      @members = Member.where(group: @task.group_id)
      @members.each do |member|
        progress = Progress.new(task_id: @task.id, member_id: member.id, completion: 0.00)
        progress.save
      end
      redirect_to group_path(@task.group_id), notice: "New task created."
    else
      render partial: "shared/addnewtask", locals: { task: @task, group: @group }, status: :unprocessable_entity
    end
  end

  def task_params
    params.require(:task).permit(:name, :quantity, :unit, :group_id)
  end
end
