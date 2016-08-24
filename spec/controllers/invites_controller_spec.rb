require 'rails_helper'

RSpec.describe InvitesController, type: :controller do

  def new_group
    Group.create!(
      name: "IHOP",
    )
  end

  def new_group2
    Group.create!(
      name: "PHHH",
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

  def new_user2
    User.create!(
      email: "h@w.com",
      password: "wordpass",
      name: "Louis",
    )
  end

  describe "GET index" do
    it "shows user a list of groups they are invited to" do
      user = new_user
      group = new_group
      group2 = new_group2
      group.add_user(user, accepted: false)
      group2.add_user(user, accepted: false)
      @request.env["HTTP_AUTHORIZATION"] = user.token
      get :index
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        invites: 
        ["IHOP", "PHHH"]
      }.to_json)
    end

    it "does not show groups the user is already a member of" do
      user = new_user
      group = new_group
      group2 = new_group2
      group.add_user(user, accepted: false)
      group2.add_user(user, accepted: true)
      @request.env["HTTP_AUTHORIZATION"] = user.token
      get :index
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        invites: ["IHOP"] 
      }.to_json)
    end

    it "only allowes user with valid token to see invites"do
      user = new_user
      group = new_group
      group.add_user(user, accepted: false)
      @request.env["HTTP_AUTHORIZATION"] = "invalid token"
      get :index
      expect(response.status).to eq 401
    end

    it "renders error information to the user if token is invalid" do
      user = new_user
      group = new_group
      group.add_user(user, accepted: false)
      @request.env["HTTP_AUTHORIZATION"] = "invalid token"
      get :index
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
  end

  describe "POST create" do
    it "allows users to invite someone to a group they are a member of" do
      user = new_user
      user2 = new_user2
      group = new_group
      group.add_user(user, accepted: true)
      @request.env["HTTP_AUTHORIZATION"] = user.token
    post :create, params: {
      user: {
        name: "Louis"
      },
      group: {
        name: "IHOP"
      },
    }
      expect(response.status).to eq 201
      expect(group.users.count).to eq 2
      expect(response.body).to be_json_eql({
        invited: "Louis",
        group: "IHOP",
      }.to_json)
    end

    it "does not allow users to invite someone to a group that they aren't a member of themselves" do
      user = new_user
      user2 = new_user2
      group = new_group
      @request.env["HTTP_AUTHORIZATION"] = user.token
    post :create, params: {
      user: {
        name: "Louis"
      },
      group: {
        name: "IHOP"
      },
    }
      expect(response.status).to eq 403
      expect(group.users.count).to eq 0
      expect(response.body).to be_json_eql({
        errors: {
          group: { user: ["is not a member"] }
        }
      }.to_json)
    end

    it "shows error info to the user if the group does not exist" do
      user = new_user
      user2 = new_user2
      @request.env["HTTP_AUTHORIZATION"] = user.token
    post :create, params: {
      user: {
        name: "Louis"
      },
      group: {
        name: "IHOP"
      },
    }
      expect(response.status).to eq 404
      expect(response.body).to be_json_eql({
        errors: {
          group: ["not found"]
        }
      }.to_json)
    end

    it "does not invite a user that does not exist in database" do
      user = new_user
      group = new_group
      group.add_user(user, accepted: true)
      @request.env["HTTP_AUTHORIZATION"] = user.token
    post :create, params: {
      user: {
        name: "claire"
      },
      group: {
        name: "IHOP"
      },
    }
      expect(response.status).to eq 404
      # expect(group.users.count).to eq 2
      expect(response.body).to be_json_eql({
        errors: {
          invited: { user: ["does not exist"] }
        }
      }.to_json)
    end
  end

  describe "PATCH update/:id" do

    it "allows user to accept an invitation to a group" do
      user = new_user
      group = new_group
      group_membership = GroupMembership.create!(group: group, user: user)
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        id: group_membership.id,
        invite: { accepted: true },
      }
      group_membership.reload
      expect(response.body).to be_json_eql({
        invite: {
          id: group_membership.id,
          accepted: true,
          group: {
            id: group.id,
            name: group.name,
          },
        },
      }.to_json)
      expect(group_membership.accepted).to eq true
    end
    it "shows user error message if invite does not exist" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        id: 131231
      }
      expect(response.body).to be_json_eql({
        errors: {
          invite: ["not found"],
        }
      }.to_json)
    end
    it "shows user error message if invite does not exist" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        id: 131231
      }
      expect(response.body).to be_json_eql({
        errors: {
          invite: ["not found"],
        }
      }.to_json)
    end
    it "does not allow a user to accept invites without a valid token"
  end
end
