require 'spec_helper'

describe CategoriesController do

  before { @category = FactoryGirl.create(:category) }

  describe "GET index" do
    it "populates an array of categories" do
      get :index
      assigns(:categories).should eq([@category])
    end

    it "renders the index view" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET show" do
    it "assigns the requested category to category variable" do
      get :show, id: @category
      assigns(:category).should eq(@category)
    end

    it "renders the show view" do
      get :show, id: @category
      response.should render_template :show
    end
  end
end

