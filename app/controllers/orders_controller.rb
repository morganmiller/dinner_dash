class OrdersController < ApplicationController
  
  def create
    if current_user
      cart = Cart.new(session[:cart])
      order = current_user.orders.new(total_price: cart.total_price)
      order.items << cart.items.keys
      order.save!
      cart.items.each do |item, quantity|
        order.order_items.create!(item: item, quantity: quantity, line_item_price: item.price * quantity.to_i)
      end
      flash[:notice] = "You have purchased #{cart.items_total} spooky item(s)"
      redirect_to orders_path
    else
      flash[:errors] = "You must log in or create an account to checkout!"
      redirect_to login_path
    end
  end
  
  def index
    @orders = Order.by_user(current_user.id)
  end
end
