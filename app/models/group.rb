class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships

  before_validation do
    self.assign_attributes(slug: self.to_slug(self.name))
  end

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  validates :slug, presence: true,
                   uniqueness: true

  def to_slug(name)
    slug = name.parameterize
    if Group.where(slug: slug).count > 0
      to_slug(slug + rand(100...999).to_s)
    else
      slug
    end
  end

  def add_user(user, accepted: nil)
    GroupMembership.new(
      group: self, user: user, accepted: accepted
    ).save
  end
end
