class OrdersController < ApplicationController
  def create
    if current_user
      cart = Cart.new(session[:cart])
      order = current_user.orders.create(total_price: cart.total_price)
      cart.items.each do |item, quantity|
        order.order_items.create!(item: item, quantity: quantity, line_item_price: item.price * quantity.to_i)
      end
      session[:cart] = {}
      flash[:notice] = "You have purchased #{cart.items_total} spooky item(s)"
      redirect_to order_path(order)
    else
      flash[:errors] = "You must log in or create an account to checkout!"
      redirect_to login_path
    end
  end

  def index
    @orders = Order.by_user(current_user.id)
  end

  def show
    @order = Order.find(params[:id])

    if @order.user != current_user
      render status: :forbidden, text: "You do not have access to this page."
    end

    @order_items = @order.order_items
  end
end
