class BooksController < ApplicationController
  include BookHelper

  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.order(created_at: :desc).paginate(page: params[:page])
    @new_comment = @book.comments.new
  end

  def search
    @books = Book.search params[:query], params[:category], params[:page], Book.per_page
  end

  def index
    @books = Book.all.paginate(page: params[:page], per_page: Book.per_page)
    build_options_for_select_category
  end
end