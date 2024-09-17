class MemberPunishment < ApplicationRecord
  belongs_to :member
  belongs_to :punishment

  enum status: { pending: 0, completed: 1 }

  validates :status, presence: true
end
