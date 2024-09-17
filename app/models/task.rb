class Task < ApplicationRecord
  belongs_to :group
  has_many :progresses, dependent: :destroy

  def total_progress(user)
    progresses = Progress.where(member: user.members.where(group_id: group.id))
    total_progress = progresses.sum(:completion)
    progress_count = progresses.count

    if progress_count > 0
      total_progress / progress_count
    else
      0.0
    end
  end

  validates :name, :unit, :quantity, presence: true
end
