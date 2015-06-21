class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  default_scope { order('created_at DESC') }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  
  validates :status,
            presence: true,
            inclusion: { in: %w(ordered paid cancelled complete), 
                         message: "must be ordered, paid, cancelled or complete."}
  
  def formatted_date
    created_at.strftime("%m/%d/%y")
  end

  def timestamp
    created_at.strftime("%H:%M")
  end

  def updated_time
    updated_at.strftime("%H:%M on %m/%d/%y")
  end
end
