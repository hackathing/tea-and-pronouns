class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships
  
  validates :name, presence: true
  
  def add_user(user)
    self.users << user 
    true
  rescue ActiveRecord::RecordInvalid => error
    if error.message == "Validation failed: User has already been taken"
      false
    else
      raise error
    end
  end
end
