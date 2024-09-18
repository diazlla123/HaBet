class Member < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :progresses, dependent: :destroy

  ### added to make the pushinments and rewards tracking feacture
  has_many :member_punishments, dependent: :destroy
  has_many :punishments, through: :member_punishments
  has_many :member_rewards, dependent: :destroy
  has_many :rewards, through: :member_rewards

  has_one_attached :photo

  # validates :user_id, uniqueness: true
  # validates :group_id, uniqueness: true
  validates :user_id, uniqueness: { scope: :group_id, message: "Already in group" }

  COLORS = ["#AEC6CF", "#77DD77", "#F7C6C7", "#B39EB5", "#FDFD96", "#FFABAB", "#FFDAB9", "#B2DFDB", "#B2DFDB", "#B2DFDB"]

  before_create :assign_random_color

  def sorted_positions
    tasks = Task.where(group_id: group.id)
    ranking_calculation = RankingCalculation.new(tasks, group.id)
    ranking_calculation.position_table
  end

  private

  def assign_random_color
    self.color = COLORS.sample
  end

end
