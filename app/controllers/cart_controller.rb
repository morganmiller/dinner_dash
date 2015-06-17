class CartController < ApplicationController
  
  def show
    @items = @cart.items
  end
  
  def create
    cart = params.select { |k,v| [k, v] if k.to_i != 0 }
    session[:cart] = cart
    redirect_to cart_path, :flash => { notice: "Your cart has been updated!" }
  end
  
end
