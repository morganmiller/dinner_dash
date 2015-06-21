class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  
  validates :status, presence: true, inclusion: { in: %w(ordered paid cancelled complete), 
                                                  message: "must be ordered, paid, cancelled or complete."}
  validate :has_at_least_one_item

  def has_at_least_one_item
    if items.empty?
      errors.add(:items, "needs at least one item!")
    end
  end
end
