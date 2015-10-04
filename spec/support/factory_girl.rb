require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name 'First'
    last_name 'Last'
    password 'password'
    password_confirmation 'password'

    factory :user_mod do
      role 'moderator'
    end

    factory :user_admin do
      role 'admin'
    end
  end

  factory :ingredient do
    sequence(:name) { |n| "ingredient#{n}" }
    factory :ingredient_subtype do
      sequence(:subtype) { |n| "subtype#{n}" }
    end
  end

  factory :category do
    sequence(:name) { |n| "category#{n}"}
  end

end
