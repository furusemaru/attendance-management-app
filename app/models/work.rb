class Work < ApplicationRecord
  belongs_to :user
  default_scope -> { order(date: :desc) }
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :comment, length: { maximum: 30 }
  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :break_time, presence: true

  def working_hours
    return unless start_time && end_time && break_time
    break_second = break_time.hour*60*60 + break_time.min*60
    working_second = end_time - start_time - break_second
    Time.at(working_second).utc.strftime('%H:%M')
  end

  def overtime_hours(threshold = 8*60*60)
    return unless start_time && end_time && break_time
    break_second = break_time.hour*60*60 + break_time.min*60
    working_second = end_time - start_time - break_second
    if working_second > threshold
      overtime_second = working_second - threshold
    else
      overtime_second = 0
    end
    Time.at(overtime_second).utc.strftime('%H:%M')
  end

  

end
