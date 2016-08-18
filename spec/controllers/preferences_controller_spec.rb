require 'rails_helper'

RSpec.describe PreferencesController, type: :controller do

  def new_user
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
      preferences: {
        tea: "chai",
        milk: true,
        sugar: 2
      }
    )
  end

  describe "GET show" do
    it "shows the user their preferences" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      get :show
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        "preferences": {
          "tea": "chai",
          "milk": true,
          "sugar": 2
        }
      }.to_json)
    end
  end

  describe "PATCH update" do
    it "allows user to update preferences" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      patch :update, params: {
        preferences: {
          tea: "black",
        }
      }
      user.reload
      expect(user.preferences).to eq("tea" => "black", "milk" => true, "sugar" => 2)
    end

    it "shows an error when request has no token" do
      @request.env["HTTP_AUTHORIZATION"] = "notarealtoken"
      patch :update
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
  end
end
