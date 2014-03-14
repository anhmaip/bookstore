require 'spec_helper'

describe CategoriesController do

  before { @category = FactoryGirl.create(:category) }

  describe "GET index" do
    before { get :index }

    it "populates an array of categories" do
      assigns(:categories).should eq([@category])
    end

    it "renders the index view" do
      response.should render_template("index")
    end
  end

  describe "GET show" do
    before { get :show, id: @category }

    it "assigns the requested category to category variable" do
      assigns(:category).should eq(@category)
    end

    it "renders the show view" do
      response.should render_template :show
    end
  end
end

