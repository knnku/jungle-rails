class User < ApplicationRecord
  has_secure_password

  # validates :email, uniqueness: true
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :email, :first_name, :last_name
  validates :password, length: { minimum: 6 }
  validates_presence_of :password_confirmation

  def self.authenticate_with_credentials(email, password)
    user = self.where("LOWER(email) = ?", email.downcase).first
    user&.authenticate(password)
  end
end