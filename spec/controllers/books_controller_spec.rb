require 'spec_helper'

describe BooksController do
  describe "GET show" do
    let(:book) { FactoryGirl.create(:book_with_comments, comment_count: 2) }
    before { get :show, id: book }

    it "assigns the requested category to category variable" do
      assigns(:book).should eq(book)
    end

    it "renders the show view" do
      response.should render_template :show
    end

    it "assigns the comments belong to requested book to comments variable" do
      assigns(:comments).count.should eq(book.comments.count)
    end
  end
end

