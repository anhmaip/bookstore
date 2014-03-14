class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :sort_order, presence: true
end
