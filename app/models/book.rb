class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :unit_price, presence: true

  has_many :comments
  has_and_belongs_to_many :categories

  self.per_page = 10

  searchable do
    text :title, :author_name
  end

  def average_rating
    if total_rating_count > 0
      total_rating_value.to_f / total_rating_count
    else
      0
    end
  end
end