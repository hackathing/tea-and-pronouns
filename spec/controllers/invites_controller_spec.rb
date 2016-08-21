require 'rails_helper'

RSpec.describe InvitesController, type: :controller do

  def new_group
    Group.create!(
      name: "IHOP",
    )
  end

  def new_user
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
      preferences: {tea: "chai"},
    )
  end

  describe "GET index" do
    it "shows user a list of groups they are invited to"
    it "does not show groups the user is already a member of"
    it "only allowes user with valid token to see invites"
    it "renders error information to the user"
  end
end
