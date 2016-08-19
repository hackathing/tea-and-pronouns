class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships

  before_validation { self.assign_attributes(slug: self.to_slug(self.name)) }

  validates :name,  presence: true,
                    uniqueness: { case_sensitive: false }

  validates :slug,  presence: true, 
                    uniqueness: true

  def to_slug(name)
    if (Group.all.pluck(:slug)).include?(self.name.parameterize)
      self.name.parameterize + rand(100...999).to_s
    else
      self.name.parameterize
    end
  end

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
