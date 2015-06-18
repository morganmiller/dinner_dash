class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            presence: true,
            uniqueness: true
  
  validates :full_name,
            presence: true
  
  validates :display_name,
            length: { in: 2..32 }
end
