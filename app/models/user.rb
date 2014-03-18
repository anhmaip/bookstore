class User < ActiveRecord::Base
  FULL_NAME_MAX_LENGTH = 100
  PASSWORD_MIN_LENGTH = 8
  VALID_PHONE_REGEX = /\A\z|\A[+]?[ ]*\d+[- \d]*\z/ # Can start with '+', can only contain digits (at least 1), '-', ' ', can be empty

  has_many :comments
  
  # Include default devise modules. Others available are:
  # :confirmable, :trackable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :full_name, presence: true, length: { maximum: FULL_NAME_MAX_LENGTH }
  validates :phone, format: { with: VALID_PHONE_REGEX }
  validate :birthday_no_later_than_today

  private
    def birthday_no_later_than_today
      errors.add(:birthday, "must be no later than today") if
          self.birthday != nil && self.birthday > Date.today
    end
end
