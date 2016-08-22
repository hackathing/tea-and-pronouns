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

    it "renders error information to the user" do
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
end
