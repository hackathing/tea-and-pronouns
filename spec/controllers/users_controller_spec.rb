require 'rails_helper'

RSpec.describe UsersController, type: :controller do

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

  def new_user3
    User.create!(
      email: "h@b.com",
      password: "wordpass",
      name: "alice amy",
    )
  end

  describe "Users index" do
    it "should display all users" do
      user = new_user
      _user2 = new_user2
      _user3 = new_user3
      @request.env["HTTP_AUTHORIZATION"] = user.token
      get :index
      expect(response.status).to eq 200
    end

    it "should not display users if valid token not present" do
     _user = new_user
      _user2 = new_user2
      _user3 = new_user3
      @request.env["HTTP_AUTHORIZATION"] = "invalid token"
      get :index
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
    it "should display users' name and gravatar url" do
      user = new_user
      user2 = new_user2
      user3 = new_user3
      @request.env["HTTP_AUTHORIZATION"] = user.token 
      get :index
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        users: 
        [{
          name: user.name, id: user.id, gravatar: user.gravatar_for(user)
        },
        {
          name: user2.name, id: user2.id, gravatar: user2.gravatar_for(user2)
      },
        {
          name: user3.name, id: user3.id, gravatar: user3.gravatar_for(user3)
        }]
      }.to_json)
    end
  end
end
