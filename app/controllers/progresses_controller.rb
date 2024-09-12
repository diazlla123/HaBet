class ProgressesController < ApplicationController
  def edit
    @progress = Progress.find(params[:id])
  end

  def update
    @progress = Progress.find(params[:id])
    current_quantity = Task.find(@progress.task_id).quantity * (@progress.completion/100)
    change = params[:new_progress].to_i
    new_quantity = current_quantity + change
    new_completion = (new_quantity / Task.find(@progress.task_id).quantity) * 100
    @progress.update(completion: new_completion)
    redirect_to groups_path
  end
end
