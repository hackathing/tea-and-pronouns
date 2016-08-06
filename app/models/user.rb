class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :password, length: { minimum: 8 }
end
