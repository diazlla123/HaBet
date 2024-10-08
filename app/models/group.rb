class Group < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :tasks, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :punishments, dependent: :destroy
  has_one :chat, dependent: :destroy

  accepts_nested_attributes_for :tasks, allow_destroy: true
  accepts_nested_attributes_for :punishments, allow_destroy: true
  accepts_nested_attributes_for :rewards, allow_destroy: true

  validates :name, presence: true
  validates :tasks, presence: true

  has_one_attached :photo

end

# :members, allow_destroy: true, uniqueness: true
