class Work < ApplicationRecord
  belongs_to :user
  default_scope -> { order(date: :desc) }
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :comment, length: { maximum: 30 }
  validates :date, presence: true, uniqueness: { scope: :user_id } # 1人のユーザーは一日に一回しか勤怠登録できない
  validates :break_time, presence: true
  validates :location, presence: true,  inclusion: { in: ['出社', 'リモート'], message: "%{value}は無効な勤務形態です" }
  validate :end_time_after_start_time

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

  private

    def end_time_after_start_time
      return if end_time.blank? || start_time.blank?

      if end_time <= start_time
        errors.add(:end_time, "must be after the start time")
      end
    end

  

end
