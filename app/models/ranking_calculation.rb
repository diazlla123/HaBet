class RankingCalculation
  def initialize(tasks, group_id)
    @tasks = tasks
    @group_id = group_id
  end

  def progress
    Progress.joins(:task)
    .select('progresses.*, tasks.*').where(tasks: { group_id: @group_id  }).joins(:member)
    .select('members.*').joins(member: :user).select('users.email, users.username').order('users.username ASC')
  end

  def position_table
    progress_data = progress

    # positions = sum(progress*task/task.size)
    # 2. Compute your positition
    average_progress_by_user = progress_data.group_by(&:username).map do |username, progresses|
      # Suma el total de las cantidades de trabajo asignadas a ese usuario


      # Suma el total del progreso completado (completion) para todas las tareas de ese usuario
      total_completion_sum = progresses.sum { |p| p.completion/100 }

      # Verificar si la cantidad total no es cero para evitar divisiones por cero
      average_progress = total_completion_sum / @tasks.size

      # Devuelve un hash con el nombre del usuario y su progreso promedio
      { username: username, average_progress: average_progress, numer_of_tasks: @tasks.size }
    end

    # positions.sort_by(progress)
    @sorted_positions = average_progress_by_user.sort_by { |user| -user[:average_progress] }

    # Includin and index to calculate your possition in the group
    @sorted_positions = @sorted_positions.each_with_index.map do |user, index|
      user.merge(rank: index + 1)
    end

  end


  def my_index(username)
    user_rank = position_table.find { |user| user[:username] == username }
    user_rank ? user_rank[:rank] : nil
  end

  def self.group_with_avances(user_id)
    Group.left_joins(:tasks, :members => :progresses)
     .select('groups.id AS id, groups.name AS name, COUNT(DISTINCT tasks.id) AS number_of_tasks, COUNT(DISTINCT members.id) AS number_of_members, SUM(progresses.completion) AS total_completion, (SUM(progresses.completion) / (COUNT(DISTINCT tasks.id) * COUNT(DISTINCT members.id))) AS avg_completion_per_task_member')
     .group('groups.id, groups.name').having('SUM(CASE WHEN members.user_id = ? THEN 1 ELSE 0 END) > 0', user_id)
  end

end
