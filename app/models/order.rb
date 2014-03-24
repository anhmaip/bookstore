class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_lines, dependent: :destroy

  validates :shipping_address, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
