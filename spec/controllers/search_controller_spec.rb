require 'rails_helper'

RSpec.describe SearchController, type: :controller do

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

  def new_user3
    User.create!(
      email: "h@b.com",
      password: "wordpass",
      name: "alice amy",
    )
  end

  describe "Post create" do
    it "should display a list of users matching the search terms" do
      user = new_user
      user2 = new_user2
      user3 = new_user3
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        search_term: "Alice",
      }
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        users: 
        [{name: user.name, id: user.id}, {name: user3.name, id: user3.id}]
      }.to_json)
    end
    it "should not display any results unless request has a valid token" do
      _user = new_user
      _user2 = new_user2
      @request.env["HTTP_AUTHORIZATION"] = "invalid token"
      post :create, params: {
        search_term: "Alice",
      }
      expect(response.status).to eq 401
      expect(response.body).to be_json_eql({
        error: "valid authorization token required"
      }.to_json)
    end
    it "should return users from non-case-sensitive search" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        search_term: "aliCe",
      }
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        users: 
        [{name: user.name, id: user.id}]
      }.to_json)
    end
    it "should match users from partial serach terms" do
      user2 = new_user2
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        search_term: "lou",
      }
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        users: 
        [{name: user2.name, id: user2.id}]
      }.to_json)
    end
    it "should return empty array if no users match terms" do
      user = new_user
      @request.env["HTTP_AUTHORIZATION"] = user.token
      post :create, params: {
        search_term: "fred",
      }
      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({ 
        users: [],
      }.to_json)
    end
  end
end
