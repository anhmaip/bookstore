require 'spec_helper'

describe Book do
  let(:book) { FactoryGirl.build(:book) }
  subject { book }

  it { should be_valid }

  [:title, :description, :author_name, :publisher_name, :published_date,
   :unit_price, :photo, :total_rating_count, :total_rating_value, :categories, :average_rating].each do |field|
    it { should respond_to(field) }
  end

  [:title, :unit_price].each do |field|
    it { should validate_presence_of(field) }
  end

  it { should have_and_belong_to_many(:categories) }
end
