class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships

  before_validation do
    if self.name.present? and self.slug.blank?
      self.slug = self.make_slug(self.name)
    end
  end

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  validates :slug, presence: true,
                   uniqueness: true

  def make_slug(name)
    slug = name.parameterize
    if Group.where(slug: slug).count > 0
      make_slug(slug + next_group_id.to_s)
    else
      slug
    end
  end

  def next_group_id
    last_group = Group.last
    if last_group.present?
      last_group.id + 1
    else
      1
    end
  end

  def add_user(user, accepted: nil)
    GroupMembership.new(
      group: self, user: user, accepted: accepted
    ).save
  end
end
