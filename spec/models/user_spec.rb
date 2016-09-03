require 'rails_helper'

RSpec.describe User, type: :model do

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

  def new_user2
    User.create!(
      email: "goodbye@world.com",
      password: "password",
      name: "Alice",
    )
  end

  def new_group
    Group.create!(
      name: "IHOP",
    )
  end

  def new_group2
    Group.create!(
      name: "Group 2",
    )
  end

  it 'is invalid without a name' do
    user = User.new(
      password: "some valid password",
      email: "amy@alice.com",
    )
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include "can't be blank"
  end

  it 'is invalid without an email' do
    user = User.new(
      password: "some valid password",
      name: "Alice",
    )
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include "can't be blank"
  end

  it 'is invalid when the email has incorrect format' do
    user = User.new(
      email: "helloworld.com",
      password: "password",
      name: "Alice",
    )
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include(
      "is invalid"
    )
  end

  it 'downcases emails before saving to database' do
    user = User.create!(
      email: "HELLO@WORLD.COM",
      password: "password",
      name: "Alice",
    )
    expect(user.email).to eq "hello@world.com"
  end

  it 'is invalid when the email is not unique' do
    user = User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
    user2 = User.create(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
    expect(user).to be_valid
    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to include(
      "has already been taken"
    )
  end

  it 'is invalid without a password' do
    user = User.new(
      email: "hello@world.com",
      name: "Alice",
    )
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include "can't be blank"
  end

  it 'is invalid when the password is short' do
    user = User.new(
      email: "hello@world.com",
      password: "123",
      name: "Alice",
    )
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include(
      "is too short (minimum is 8 characters)"
    )
  end

  it 'has a secure password' do
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
    user = User.find_by(email: "hello@world.com")
    expect(user.password).to eq nil
    expect(user.password_digest).not_to eq nil
    expect(user.authenticate('password')).to eq user
  end

  it "does not require password when updating user, if password is not given" do
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
    user = User.find_by(email: "hello@world.com")
    user.update(:email => "goodbye@world.com")
    user.reload
    expect(user).to be_valid
    expect(user.email).to eq "goodbye@world.com"
  end

  it "allows user to add preferences" do
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
    user = User.find_by(email: "hello@world.com")
    user.preferences.update("tea" => "chai")
    user.save!
    user.reload
    expect(user.preferences).to eq(
      "tea" => "chai"
    )
  end

  it "can have groups belong to it" do
    group = new_group
    user = new_user
    expect(user.groups.count).to eq 0
    user.groups << group
    user.reload
    expect(user.groups.count).to eq 1
    expect(user.groups.pluck(:name)).to eq ["IHOP"]
    expect(user.groups).to eq [group]
  end

  describe "#search" do

    it "finds name in database and returns asscoiated user(s)" do
      user = new_user
      user2 = new_user2
      expect(User.search "Alice").to eq [user, user2]
    end

    it "finds email in database and returns associated user" do
      user2 = new_user2
      expect(User.search "goodbye@world.com").to eq [user2]
    end

    it "is not case sensitive" do
      user = new_user
      user2 = new_user2
      expect(User.search "aLicE").to eq [user, user2]
    end

    it "matches on a the first part of an incomplete field" do
      user = new_user
      expect(User.search "al").to eq [user]
    end

    it "only searches name and email columns" do
      user = new_user
      expect(User.search "chai").to eq []
    end
  end

  describe "#group_invites" do

    it "shows users the groups they are invited to" do
      group = new_group
      user = new_user
      group.add_user(user, accepted: false)
      expect(user.group_invites(user)).to eq ["IHOP"]
    end

    it "doesn't show the user groups they have already accepted" do
      group = new_group
      group2 = new_group2
      user = new_user
      group.add_user(user, accepted: true)
      group2.add_user(user, accepted: false)
      expect(user.group_invites(user)).to eq ["Group 2"]
    end
  end
end
