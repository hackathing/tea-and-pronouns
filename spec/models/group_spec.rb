require 'rails_helper'

RSpec.describe Group, type: :model do

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

  it "is invalid without a name" do
    group = Group.new()
    expect(Group.count).to eq 0
    expect(group).not_to be_valid
    expect(group.errors[:name]).to include "can't be blank"
  end

  it "can have users belong to it" do
    group = new_group
    user = new_user
    expect(group.users.count).to eq 0
    group.users << user
    group.reload
    expect(group.users.count).to eq 1
    expect(group.users.pluck(:name)).to eq ["Alice"]
  end

  describe "#add_user" do
    it "adds a user to the group" do
      group = new_group
      user = new_user
      expect(group.add_user(user)).to eq true
      expect(group.users).to include user
      expect(user.groups).to include group

    end

    it "returns false if the user is already in the group" do
      group = new_group
      user = new_user
      group.add_user(user)
      expect(group.users.count).to eq 1
      expect(group.add_user(user)).to eq false
      expect(group.users.count).to eq 1
    end

    it "doesn't swallow other errors" do
      group = new_group
      expect { group.add_user("turnip") }.to raise_error(
        ActiveRecord::AssociationTypeMismatch,
      )
      user = new_user
      def user.id
        raise RuntimeError, "Explodey!"
      end
      expect { group.add_user(user) }.to raise_error(
        RuntimeError, "Explodey!"
      )
    end
  end

  describe "slug generation" do
    it "creates valid slug for the group from the group name" do
      group = Group.new(name: "IHop Upstairs")
      group.save
      expect(group.slug).to eq "ihop-upstairs"
    end

    it "does not change slugs once it has one" do
      Group.create!(name: "IHop Upstairs") 
      group = Group.new(name: "IHop Upstairs")
      group.validate
      slug = group.slug
      group.validate
      expect(group.slug).to eq slug
    end

    it "makes sure the slug is unique" do
      group = Group.new(name: "IHop Upstairs")
      group.save
      group2 = Group.create!(name: "ihop upstairs ")
      expect(group2.slug).not_to eq group.slug
      expect(group2.slug).not_to eq "ihop-upstairs"
    end
  end
end
