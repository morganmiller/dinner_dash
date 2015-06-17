class CartController < ApplicationController
  
  def show
    @items = @cart.items
  end
  
  def create
    total_items = update_cart_params.values(&:to_i).sum
    session[:cart] = update_cart_params
    flash[:notice] = "Your cart has been updated! You now have #{total_items} items in your cart."
    redirect_to cart_path
  end
  
private
  
  def update_cart_params
    params[:new_cart] #can we use params.require(:something).permit(:new_cart) here?
  end
end
