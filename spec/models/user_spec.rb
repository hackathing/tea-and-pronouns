require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is invalid without an email' do
    user = User.new(
      password: "some valid password",
    )
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include "can't be blank"
  end

  it 'is invalid when the email has incorrect format' do
    user = User.new(
      email: "helloworld.com",
      password: "password",
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
    )
    expect(user.email).to eq "hello@world.com"
  end

  it 'is invalid when the email is not unique' do
    user = User.create!(
      email: "hello@world.com",
      password: "password",
    )
    user2 = User.create(
      email: "hello@world.com",
      password: "password",
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
    )
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include "can't be blank"
  end

  it 'is invalid when the password is short' do
    user = User.new(
      email: "hello@world.com",
      password: "123",
    )
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include(
      "is too short (minimum is 8 characters)"
    )
  end


  it 'has a secure password' do
    User.create!(
      email: "hello@world.com",
      password: "password"
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
    )
    user = User.find_by(email: "hello@world.com")
    user.update(:email => "goodbye@world.com")
    expect(user).to be_valid
    expect(user.email).to eq "goodbye@world.com"
  end
end
