class User < ApplicationRecord
  has_many :works, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  before_validation :assign_employee_id, on: :create
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :department, presence: true, inclusion: { in: ['営業', '開発', '人事', '総務'], message: "%{value}は無効な部署です" }
  validates :employee_id, uniqueness: true, presence: true, format: { with: /\A\d{7}\z/, message: "は7桁の数字で入力してください" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def session_token
    remember_digest || remember
  end

  def fullname
    last_name + ' ' + first_name
  end 

  def total_working_hours(month, year)
    works_in_month = works.where("strftime('%Y', works.date) = ? AND strftime('%m', works.date) = ?", year, month)
    total = 0
    works_in_month.each do |work|
      break_second = work.break_time.hour*60*60 + work.break_time.min*60
      working_second = work.end_time - work.start_time - break_second
      total += working_second
    end
    hours, total = total.divmod(3600)
    minutes, total = total.divmod(60)
    "#{hours}時間#{minutes}分"
  end

  def total_overtime_hours(month, year, threshold = 8*60*60)
    works_in_month = works.where("strftime('%Y', works.date) = ? AND strftime('%m', works.date) = ?", year, month)
    total = 0
    works_in_month.each do |work|
      break_second = work.break_time.hour*60*60 + work.break_time.min*60
      working_second = work.end_time - work.start_time - break_second
      if working_second > threshold
        overtime_second = working_second - threshold
      else
        overtime_second = 0
      end
      total += overtime_second
    end
    hours, total = total.divmod(3600)
    minutes, total = total.divmod(60)
    "#{hours}時間#{minutes}分"
  end

  def overtime_this_month(threshold = 8*60*60)
    this_month = Date.today.month
    this_month = this_month < 10 ? '0' + this_month.to_s : this_month.to_s 
    works_in_month = works.where("strftime('%Y', works.date) = ? AND strftime('%m', works.date) = ?", Date.today.year.to_s, this_month)
    total_overtime = 0
    works_in_month.each do |work|
      break_second = work.break_time.hour*60*60 + work.break_time.min*60
      working_second = work.end_time - work.start_time - break_second
      if working_second > threshold
        overtime_second = working_second - threshold
      else
        overtime_second = 0
      end
      total_overtime += overtime_second
    end
    total_overtime
  end

  private

    def assign_employee_id
      self.employee_id ||= next_employee_id
    end

    def next_employee_id
      last_user = User.order(employee_id: :desc).first
      if last_user
        last_id = last_user.employee_id.to_i
        new_id = format('%07d', last_id + 1)
      else
        new_id = '0000001'
      end
      new_id
    end
end
