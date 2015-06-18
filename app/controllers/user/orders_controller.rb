class User::OrdersController < User::BaseController
  def create
    cart = Cart.new(session[:cart])
    order = current_user.orders.create(total_price: cart.total_price)


  end
end
