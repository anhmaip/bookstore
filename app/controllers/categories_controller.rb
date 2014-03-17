class CategoriesController < ApplicationController
  def index
    @categories = Category.all.sort_by &:sort_order
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books.paginate(page: params[:page], per_page: 10)
  end
end
