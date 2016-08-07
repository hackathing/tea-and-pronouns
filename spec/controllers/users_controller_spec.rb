require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST create" do
    it "TODO: test controller" do
      post :create, params: {
        email: "hello@world.com",
        password: "password123",
      }
      expect(response.status).to eq 200
    end
  end
end
