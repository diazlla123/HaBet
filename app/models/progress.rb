class Progress < ApplicationRecord
  belongs_to :task
  belongs_to :member
end
