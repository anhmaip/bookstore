require 'spec_helper'

describe Comment do
  let(:comment) { FactoryGirl.build(:comment) }
  subject { comment }

  it { should be_valid }

  [:rating, :content, :book, :user].each do |field|
    it { should respond_to(field) }
  end

  it { should validate_presence_of(:content) }
  it { should belong_to(:book) }
  it { should belong_to(:user) }

  describe "when rating is less than 1" do
    before { comment.rating = 0 }
    it { should be_invalid }
  end

  describe "when rating is greater than 5" do
    before { comment.rating = 6 }
    it { should be_invalid }
  end
end