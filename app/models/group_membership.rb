class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user, uniqueness: { scope: :group }
end
