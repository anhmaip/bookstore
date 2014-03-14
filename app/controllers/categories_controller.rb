class CategoriesController < ApplicationController
  def index
    @categories = Category.all.sort_by &:sort_order
  end

  def show
    @categories = Category.find(params[:id])
  end
end
