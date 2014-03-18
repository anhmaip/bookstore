class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end