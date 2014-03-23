class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_rating_count, presence: true, numericality: { only_integer:true, greater_than_or_equal_to: 0 }
  validates :total_rating_value, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :categories

  self.per_page = 10

  searchable do
    text :title, :author_name
    integer :category, multiple: true do
      categories.map { |category| category.id }
    end
  end

  def average_rating
    if total_rating_count > 0
      total_rating_value.to_f / total_rating_count
    else
      0
    end
  end

  def self.search keyword, category, page, per_page
    Sunspot.search(Book) do
      keywords keyword
      with :category, category if category.present?
      paginate page: page, per_page: per_page
    end.results
  end
end