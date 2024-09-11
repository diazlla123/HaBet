class Task < ApplicationRecord
  belongs_to :group
  has_many :progresses, dependent: :destroy
end
