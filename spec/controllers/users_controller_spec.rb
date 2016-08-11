require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST create" do
    it "creates a new User" do
      expect(User.count).to eq 0
      post :create, params: {
        user: {
          email: "hello@world.com",
          password: "password123",
        }
      }
      expect(User.count).to eq 1
      user = User.first
      expect(user).not_to eq nil
      expect(user.email).to eq "hello@world.com"
    end

    it "renders user information to the user" do
      post :create, params: {
        user: {
          email: "hello@world.com",
          password: "password123",
        }
      }
      expect(response.status).to eq 201
      user = User.first
      expect(response.body).to be_json_eql({
        user: {
          persisted: true,
          email: "hello@world.com",
          token: user.token,
        },
      }.to_json)
    end

    it "does not create a user if params are invalid" do
      expect(User.count).to eq 0
      post :create, params: {}
      expect(response.status).to eq 400
      expect(User.count).to eq 0
    end

    it "renders error information to the user when params are invalid" do
      post :create, params: {
        user: {
          email: "helloworld",
          password: "password123",
        }
      }
      expect(response.status).to eq 400
      expect(response.body).to be_json_eql({
        errors: {
          user: { email: ["is invalid"] },
        },
      }.to_json)
    end

     it "assigns a token to the user" do
      post :create, params: {
        user: {
          email: "hello@world.com",
          password: "password123",
        }
      }
      expect(response.status).to eq 201
      user = User.first
      expect(user.token).not_to eq nil
    end  

  end
end
