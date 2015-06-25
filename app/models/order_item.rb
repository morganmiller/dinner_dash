class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  scope :by_user, -> (user_id) { where(user_id: user_id) }

  def item
    Item.find(item_id)
  end
end
