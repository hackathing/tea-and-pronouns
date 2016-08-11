require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST create" do
    
    it "creates a new session" do
      user = User.create!(
      email: "hello@world.com",
      password: "password123",
      )
      post :create, params: {
        user: {
          email: "hello@world.com",
          password: "password123",
        }
      }
      expect(response.status).to eq 201
    end

    it "renders user information to the user" do
      user = User.create!(
      email: "hello@world.com",
      password: "password123",
      )
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
    
    it "does not create a session if params are invalid" do
      user = User.create!(
      email: "hello@world.com",
      password: "password123",
      )
      post :create, params: {
        user: {
          email: "hello@world.com",
        }
      }
      expect(response.status).to eq 400
    end

    xit "does not create a session if no params given" do
      user = User.create!(
      email: "hello@world.com",
      password: "password123",
      )
      post :create, params: {}
      expect(response.status).to eq 400
    end

  end
end

