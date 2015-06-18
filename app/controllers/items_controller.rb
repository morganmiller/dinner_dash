class ItemsController < ApplicationController
  def index
    @categories = Category.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
