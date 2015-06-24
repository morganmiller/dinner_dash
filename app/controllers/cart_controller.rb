class CartController < ApplicationController
  def show
    @items = @cart.items
    @cart = Cart.new(session[:cart])
  end

  def create
    session[:cart] = update_cart_params
    cart = Cart.new(session[:cart])
    flash[:notice] = "Your cart has been updated! You now have #{cart.items_total} items in your cart."
    redirect_to cart_path
  end

private

  def update_cart_params
    params[:new_cart] #can we use params.require(:something).permit(:new_cart) here?
  end
end
