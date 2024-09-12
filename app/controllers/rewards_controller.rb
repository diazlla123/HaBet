class RewardsController < ApplicationController

  def index


    # Verificar numers of task that are in the group
    # 1. Compute your average avance

    @progress = Progress.joins(task: { group: :members }, member: :user)
        .select('users.username, tasks.name AS task_name, tasks.unit, tasks.quantity, progresses.completion')
        .where(tasks: { group_id: params[:group_id]})

    # positions = sum(progress*task/task.size)
    # 2. Compute your positition
    average_progress_by_user = @progress.group_by(&:username).map do |username, progresses|
      total_quantity = progresses.sum { |p| p.quantity }
      weighted_progress_sum = progresses.sum { |p| p.completion * p.quantity }
      average_progress = weighted_progress_sum / total_quantity unless total_quantity.zero?
      { username: username, average_progress: average_progress || 0 }
    end

    # positions.sort_by(progress)
    @sorted_positions = average_progress_by_user.sort_by { |user| -user[:average_progress] }
    # 3. Determine if you get a reward
    # generate a table with user_id, postions, and reward
    @group = Group.find(params[:group_id])
    @group.rewards
  end

end
