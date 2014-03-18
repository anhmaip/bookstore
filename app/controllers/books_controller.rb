class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.order("created_at DESC").paginate(page: params[:page], per_page: 10)
    @new_comment = Comment.new
  end
end