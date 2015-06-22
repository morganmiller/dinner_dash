class User < ActiveRecord::Base
  before_save :set_display_name
  has_secure_password
  has_many :orders

  validates :email,
            presence: true,
            uniqueness: true

  validates :full_name,
            presence: true

  validates :display_name,
            length: { in: 2..32 },
            allow_blank: true

  validates_format_of :email, with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/

  enum role: %w(default admin)

  def set_display_name
    if display_name.nil? || display_name == ""
      self.display_name = full_name
    end
  end
end
