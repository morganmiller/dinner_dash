class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  def item
    Item.find(item_id)
  end
end
