class Member < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :progresses, dependent: :destroy

  # validates :user_id, uniqueness: true
  # validates :group_id, uniqueness: true
  validates :user_id, uniqueness: { scope: :group_id, message: "Already in group" }
end
