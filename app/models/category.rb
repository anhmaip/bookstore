class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :sort_order, presence: true

  has_and_belongs_to_many :books
end
