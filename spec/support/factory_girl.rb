require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user#{n}"}
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name 'First'
    last_name 'Last'
    password 'password'
    password_confirmation 'password'
  end

end
