class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all

    @ordered_orders = Order.by_status("ordered")
    @paid_orders = Order.by_status("paid")
    @cancelled_orders = Order.by_status("cancelled")
    @completed_orders = Order.by_status("complete")
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @order_items = @order.order_items
  end
end
