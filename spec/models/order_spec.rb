require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.build(:order) }

  subject { order }

  it { should be_valid }

  [:id, :total_amount, :shipping_address, :created_at].each do |field|
    it { should respond_to(field) }
  end

  it { should have_many(:order_lines) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:shipping_address) }
  it { should validate_presence_of(:total_amount) }
  it { should validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }

  it "should have total_amount being equal to the sum of all line prices" do
      sum = 0
      order.order_lines.each do |line|
        sum += line.unit_price * line.quantity
      end
      expect(order.total_amount).to eq sum
  end
end