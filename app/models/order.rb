class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  
  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
