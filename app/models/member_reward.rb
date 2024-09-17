class MemberReward < ApplicationRecord
  belongs_to :member
  belongs_to :reward

  enum status: { available: 0, claimed: 1 }

  validates :status, presence: true
end
