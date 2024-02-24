class Work < ApplicationRecord
  belongs_to :user
  default_scope -> { order(date: :desc) }
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :comment, length: { maximum: 100 }
  validates :date, uniqueness: { scope: :user_id }
end
