require 'rails_helper'

RSpec.describe User, type: :model do

  def new_user
    User.create!(
      email: "hello@world.com",
      password: "password",
      name: "Alice",
    )
  end

  def new_group
    Group.create!(
      name: "IHOP",
    )
  end
  
  it "prevents a group from having the same user twice" do
    user = new_user
    group = new_group
    user.groups << group
    user.reload
    expect(user.groups.count).to eq 1
    expect { user.groups << group }.to raise_error(
      ActiveRecord::RecordInvalid
    )
    # try to re-add the same user
    user.reload
    expect(user.groups.count).to eq 1
  end
end
