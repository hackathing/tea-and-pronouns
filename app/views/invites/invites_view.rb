module InvitesView

  def groups_invited_to(user)
    user.group_memberships.includes(:group)
    {
      invites: user.group_invites(user)
    }
  end

  def invited_success(invited_user, group)
    {
      invited: invited_user.name,
      group: group.name
    }
  end

  def invited_error
    {
      errors: {
        invited: { user: ["does not exist"] }
      }
    }
  end

  def  membership_error
    {
      errors: {
        group: { user: ["is not a member"] }
      }
    }
  end

  def invite_updated(membership)
    {
      invite: {
        id: membership.id,
        accepted: membership.accepted?,
        group: {
          id: membership.group.id,
          name: membership.group.name,
        }
      }
    }
  end

  def group_not_found_error
    {
      errors: {
        group: ["not found"]
      }
    }
  end

  def invite_not_found_error
    {
      errors: {
        invite: ["not found"]
      }
    }
  end

end
