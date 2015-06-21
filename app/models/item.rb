class Item < ActiveRecord::Base
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :has_at_least_one_category

  def has_at_least_one_category
    if categories.empty?
      errors.add(:items, "needs at least one category!")
    end
  end
  # scope :category, -> (category) { where category: category }
end
