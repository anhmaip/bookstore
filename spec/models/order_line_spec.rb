require 'spec_helper'

describe OrderLine do
  let(:order_line) { FactoryGirl.build(:order_line) }

  subject { order_line }

  it { should be_valid }
  it { should belong_to(:order) }
  it { should belong_to(:book) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  it { should validate_numericality_of(:quantity).only_integer }
end
