class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_secure_password

  VALID_EMAIL_REGEX = /.+\@.+\..+/

  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

end
