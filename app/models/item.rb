class Item < ActiveRecord::Base
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items

  has_attached_file :image,
                    :default_url => "http://ak-hdl.buzzfed.com/static/enhanced/web03/2012/8/13/15/enhanced-buzz-24632-1344884422-14.jpg",
                    :styles => { :medium => "500x500!", :thumb => "200x200!" }

  validates_attachment_content_type :image,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png"]


  validate :has_at_least_one_category

  validates :title,
            presence: true,
            uniqueness: true

  validates :description, presence: true

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }

  scope :not_retired, -> { where(retired: false) }
  
  def has_at_least_one_category
    if categories.empty?
      errors.add(:items, "needs at least one category!")
    end
  end
end
