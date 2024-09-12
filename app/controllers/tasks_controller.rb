class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save!
      redirect_to group_path(@task.group_id), notice: "New task created."
    else
      render 'group', notice: "mamaste"
    end
  end

  def task_params
    params.require(:task).permit(:name, :quantity, :unit, :group_id)
  end
end
