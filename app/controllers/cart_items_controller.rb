class CartItemsController < ApplicationController
  before_action :set_item

  def create
    @cart.add_item(@item.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def destroy
    @cart.delete_item(@item.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
