class ItemsController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @categories = @item.categories.uniq
  end
end
