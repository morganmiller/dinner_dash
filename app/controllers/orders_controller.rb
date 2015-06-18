class OrdersController < ApplicationController
  def create
    cart = Cart.new(session[:cart])
    order = current_user.orders.create(total_price: cart.total_price)
    cart.items.each do |item, quantity|
      order.order_items.create(item: item, quantity: quantity, line_item_price: item.price * quantity)
    end
    flash[:notice] = "You have purchased #{cart.items_total} spooky item(s)"
    redirect_to orders_path
  end
  
  def index
    @orders = Order.by_user(current_user.id)
  end
end
