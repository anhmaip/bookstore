class User < ActiveRecord::Base
  FULL_NAME_MAX_LENGTH = 100

  # Include default devise modules. Others available are:
  # :confirmable, :trackable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: { maximum: FULL_NAME_MAX_LENGTH }
  validate :birthday_no_later_than_today

  private
    def birthday_no_later_than_today
      errors.add(:birthday, "must be no later than today") if
          self.birthday != nil && self.birthday > Date.today
    end
end
