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
    sequence(:name) { |n| "category#{n}" }
  end

  factory :recipe do
    sequence(:name) { |n| "recipe#{n}" }
    user

    factory :recipe_numbers do
      cooking_time { rand(5..60) }
      num_served_min { rand(2..4) }
      num_served_max { rand(4..8) }
      complexity { rand(1..3) }

      factory :recipe_complete do
        transient do
          recipe_steps_count { rand(4..8) }
          ingredient_lists_count { rand(5..15) }
          categories_count { rand(0..3) }
        end

        after(:create) do |recipe, evaluator|
          create_list(
            :recipe_step,
            evaluator.recipe_steps_count,
            recipe: recipe)
          create_list(
            :ingredient_list,
            evaluator.ingredient_lists_count,
            recipe: recipe,
            recipe_step: recipe.recipe_steps.to_a.sample)
          create_list(
            :recipe_category,
            evaluator.categories_count,
            recipe: recipe)
        end
      end
    end
  end

end
