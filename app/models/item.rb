class Item < ActiveRecord::Base
  has_many :item_categories
  has_many :categories, through: :item_categories

  # scope :category, -> (category) { where category: category }
end
