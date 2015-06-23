class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @items = @category.items.uniq
  end
end
