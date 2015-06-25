module OrderCreator
  
  def self.execute_order(cart, user)
    @cart = cart
    Order.transaction do
      order = user.orders.create(total_price: cart.total_price)
      create_order_items(order)
    end
  end

  def self.create_order_items(order)
    @cart.items.each do |item, quantity|
      order.order_items.create!(item: item, quantity: quantity, line_item_price: item.price * quantity.to_i)
    end
  end
end
