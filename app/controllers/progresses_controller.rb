class ProgressesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @progress = Progress.find(params[:id])
  end

  def update
    @progress = Progress.find(params[:id])
    task = @progress.task
    group = task.group
    member = @progress.member

    # Calculate current progress quantity
    current_quantity = task.quantity * (@progress.completion / 100.0)

    # Get the change from params
    change = params[:new_progress].to_f

    # Calculate new total quantity and completion percentage
    new_quantity = current_quantity + change
    new_completion = (new_quantity / task.quantity) * 100.0

    # Ensure new_completion is within 0% to 100%
    new_completion = [[new_completion, 0].max, 100].min

    if @progress.update(completion: new_completion)
      check_punishments_and_rewards(member, group)
      redirect_to group_path(group), notice: 'Progress updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def check_punishments_and_rewards(member, group)
    # Calculate the member's average completion across all tasks in the group
    total_completion = member.progresses.joins(:task).where(tasks: { group_id: group.id }).average(:completion) || 0.0

    # ask my group to change this logic for assign pushiments and rewards
    # Check for punishment if any task completion is below the threshold
    if member.progresses.joins(:task).where(tasks: { group_id: group.id }).where('completion < ?', 50.0).exists?
      assign_punishment(member, group)
    end

    # Check for reward if total average completion is 100%
    if total_completion >= 100.0
      assign_reward(member, group)
    end
  end

  def assign_punishment(member, group)
    # Select a punishment (customize as needed)
    punishment = group.punishments.first
    return unless punishment

    unless member.member_punishments.exists?(punishment: punishment, status: 'pending')
      member.member_punishments.create(punishment: punishment, status: 'pending')
      # Optionally, send a notification to the member
    end
  end

  def assign_reward(member, group)
    # Select a reward (customize as needed)
    reward = group.rewards.first
    return unless reward

    unless member.member_rewards.exists?(reward: reward, status: 'available')
      member.member_rewards.create(reward: reward, status: 'available')
      # Optionally, send a notification to the member
    end
  end

end
