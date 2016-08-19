require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

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

  describe "POST create" do
    it "allows user to create a group" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      expect(Group.count).to eq 0
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 201
      expect(Group.count).to eq 1
      group = Group.first
      expect(group.name).to eq "IHOP"
    end

    it "automatically makes the user of a group they have created" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      group = Group.first
      expect(group.users.pluck(:name)).to eq ["Alice"]

    end

    it "only allows users with valid token to create groups" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = "invalid_token"
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 401
      expect(Group.count).to eq 0
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end

    it "renders group information to user on create sucess" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 201
      expect(response.body).to be_json_eql({
        group: {
          name: "IHOP",
          slug: "ihop",
          members: ["Alice"]
        }
      }.to_json)
    end

    it "does not allow a group with the same name to be created" do
      group = new_group
      user = new_user
      expect(Group.count).to eq 1
      group.reload
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 404
      expect(Group.count).to eq 1
    end

    it "renders error information to user on create failure" do
      group = new_group
      user = new_user
      group.reload
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 404
      expect(Group.count).to eq 1
      expect(response.body).to be_json_eql({
        errors: {
          group: { 
            name: ["has already been taken"],
          },
        },
      }.to_json)
    end

    it "creates a valid slug for the group name" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 201
      group = Group.first
      expect(group.slug).to eq "ihop"
    end

    it "returns the slug to the user on successful creation"do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        group: {
          name: "IHOP",
        }
      }
      expect(response.status).to eq 201
      group = Group.first
      expect(group.slug).to eq "ihop"
      expect(response.body).to be_json_eql({
        group: {
          name: "IHOP",
          slug: "ihop",
          members: ["Alice"]
        }
      }.to_json)
    end
  end
end
