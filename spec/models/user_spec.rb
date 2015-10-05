require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many :recipes }

  it { should have_valid(:email).when("email@gmail.com", "gmail@email.com") }
  it { should_not have_valid(:email).when(nil, '', 'zest.com') }

  it { should have_valid(:password).when("awefsdfs", "2133fewfs") }
  it { should_not have_valid(:password).when(nil, '', '16', 'pwd') }

  it { should have_valid(:username).when("billybob", "suejoe") }
  it { should_not have_valid(:username).when(nil, '') }

  it { should have_valid(:first_name).when("Larry", "Bob") }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when("Johnson", "Bob") }
  it { should_not have_valid(:last_name).when(nil, '') }

  it "role should default to member" do
    user = User.create!(
      username: "bobby",
      email: "bob@gmail.com",
      password: "password",
      first_name: "Bob",
      last_name: "Roberts"
      )
    expect(user.role).to eq("member")
  end

  it "should not accept nonunique emails" do
    User.create!(
      username: "bobby",
      email: "bob@gmail.com",
      password: "password",
      first_name: "Bob",
      last_name: "Roberts"
      )
    user = User.new(
      username: "billy",
      email: "bob@gmail.com",
      password: "wordpass",
      first_name: "Bob",
      last_name: "Roberts"
      )
    expect(user.valid?).to eq(false)
    expect(user.errors.full_messages[0]).to eq("Email has already been taken")
  end

  it "should not accept nonunique usernames" do
    User.create!(
      username: "bobby",
      email: "bob@gmail.com",
      password: "password",
      first_name: "Bob",
      last_name: "Roberts"
      )
    user = User.new(
      username: "bobby",
      email: "billy@gmail.com",
      password: "wordpass",
      first_name: "Bob",
      last_name: "Roberts"
      )
    expect(user.valid?).to eq(false)
    expect(user.errors.full_messages[0]).to eq(
      "Username has already been taken")
  end

  it "should have full name" do
    user = FactoryGirl.create(:user)
    expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
  end

end
