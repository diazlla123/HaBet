class RewardsController < ApplicationController

  def index

    # Verificar numers of task that are in the group
    # 1. Compute your average avance
    #

    @tasks = Task.where(group_id: params[:group_id])

    # Initialize the ranking calculation with tasks and group_id
    ranking_calculation = RankingCalculation.new(@tasks, params[:group_id])

    # Get the progress and sorted positions
    @progress = ranking_calculation.progress
    @sorted_positions = ranking_calculation.position_table


    # 3. Determine if you get a reward
    # generate a table with user_id, postions, and reward
    @group = Group.find(params[:group_id])

    @my_index = ranking_calculation.my_index(current_user.username)

  end

  def update
    @group = Group.find(params[:id])
    @reward = @group.rewards.find(params[:id])
    if @reward.update(reward_params)
      redirect_to group_path(@group), notice: "Reward updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:name)
  end

end
