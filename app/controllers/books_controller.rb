class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.order("created_at DESC").paginate(page: params[:page], per_page: Book.per_page)
    @new_comment = Comment.new
  end

  def search
    @books = Book.search do
      keywords params[:query]
    end.results
    render :index
  end

  def index
    @books = Book.all.paginate(page: params[:page], per_page: 10)
  end
end