class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :email,
            presence: true,
            uniqueness: true

  validates :full_name,
            presence: true

  validates :display_name,
            length: { in: 2..32 }

  enum role: %w(default admin)
end
