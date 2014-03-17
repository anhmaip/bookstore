class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :unit_price, presence: true

  has_and_belongs_to_many :categories

  def average_rating
    if total_rating_count != 0
      total_rating_value.to_f / total_rating_count
    else
      0
    end
  end
end
