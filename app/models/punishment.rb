class Punishment < ApplicationRecord
  belongs_to :group

  # Added to implement tracking feacture of pushinments and rewards
  has_many :member_punishments, dependent: :destroy
  has_many :members, through: :member_punishments
end
