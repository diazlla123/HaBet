class Member < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :progresses, dependent: :destroy

  # validates :user_id, uniqueness: true
  # validates :group_id, uniqueness: true
  validates :user_id, uniqueness: { scope: :group_id, message: "Already in group" }

  COLORS = ["#AEC6CF", "#77DD77", "#F7C6C7", "#B39EB5", "#FDFD96", "#FFABAB", "#FFDAB9", "#B2DFDB", "#B2DFDB", "#B2DFDB"]

  before_create :assign_random_color

  private

  def assign_random_color
    self.color = COLORS.sample
  end

end
