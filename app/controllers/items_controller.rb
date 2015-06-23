class ItemsController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.not_retired
  end

  def show
    @item = Item.find(params[:id])
    @categories = @item.categories.uniq
  end
end
