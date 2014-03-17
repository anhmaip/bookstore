class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :unit_price, presence: true

  has_and_belongs_to_many :categories
end
