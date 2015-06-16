class CartItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])

    @cart.add_item(item.id)

    session[:cart] = @cart.contents

    redirect_to cart_items_path
  end

  def index
    @items = @cart.items
    
  end
end
