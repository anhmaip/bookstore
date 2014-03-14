require 'spec_helper'

describe Category do
  let(:category) { FactoryGirl.build(:category) }

  subject { category }

  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:sort_order) }

  it { should be_valid }

  describe "when name is not present" do
    before { category.name = " " }
    it { should_not be_valid }
  end

  describe "when sort order is not present" do
    before { category.sort_order = " " }
    it { should_not be_valid }
  end
end
