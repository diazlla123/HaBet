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
    # Calculate average completion for all members in the group
    member_progress = group.members.includes(:progresses).map do |m|
      avg_completion = m.progresses.joins(:task).where(tasks: { group_id: group.id }).average(:completion) || 0.0
      { member: m, average_completion: avg_completion }
    end
    # Sort members by their average completion in descending order
    sorted_members = member_progress.sort_by { |mp| -mp[:average_completion] }
    # Find the member in the first position (highest average completion)
    top_member = sorted_members.first
    # Check if the top member has reached 100% average completion
    if top_member[:average_completion] >= 100.0
      # Find the member in the last position (lowest average completion)
      last_member = sorted_members.last
      # Assign punishment to the last member if not already assigned
      assign_punishment(last_member[:member], group)
      # Assign reward to the top member if not already assigned
      assign_reward(top_member[:member], group)
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
