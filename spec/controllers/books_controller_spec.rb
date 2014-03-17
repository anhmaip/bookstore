require 'spec_helper'

describe BooksController do
  describe "GET show" do
    let(:book) { FactoryGirl.create(:book) }
    before { get :show, id: book }

    it "assigns the requested category to category variable" do
      assigns(:book).should eq(book)
    end

    it "renders the show view" do
      response.should render_template :show
    end
  end
end

