class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_secure_password
  has_secure_token

  VALID_EMAIL_REGEX = /.+\@.+\..+/

  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password,  length: { minimum: 8 },
                        allow_nil: true

  validates :name, presence: true
end
