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
      expect(response.status).to eq 201
      expect(User.count).to eq 1
      user = User.first
      expect(user).not_to eq nil
      expect(user.email).to eq "hello@world.com"
    end

    it "does not create a user if params are invalid" do
      expect(User.count).to eq 0
      post :create, params: {}
      expect(response.status).to eq 400
      expect(User.count).to eq 0
    end
  end
end
