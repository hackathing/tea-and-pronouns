require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

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
    )
  end

  describe "GET show" do
    it 'shows the current user' do
      user = new_user
      group = new_group
      group.add_user(user)
      @request.env["HTTP_AUTHORIZATION"] = user.token
      get :show
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        profile: {
          name: "Alice",
          email: "hello@world.com",
          id: user.id,
          persisted: true,
          avatar: user.gravatar_for(user),
          groups: ["IHOP"]
        }
      }.to_json)
    end
    it "shows an error when request has no token" do
      get :show
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
  end

  describe "PATCH update" do
    it "allows user to update name" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        profile: {
          name: "Al",
        }
      }
      user.reload
      expect(user.name).to eq "Al"
    end
 it "allows user to update email" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        profile: {
          email: "goodbye@world.com",
        }
      }
      user.reload
      expect(user.email).to eq "goodbye@world.com"
    end
    it "allows user to update password" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        profile: {
          password: "newpassword",
        }
      }
      user.reload
      expect(user.authenticate("newpassword")).to eq user
      expect(user.authenticate("password")).not_to eq user
    end
    it "shows an error when request has no token" do
      patch :update
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
  end
end
