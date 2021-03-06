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

  factory :ingredient_list do
    ingredient
    recipe
    amount "amount"
    preparation "preparation"
    step { rand(1..6) }
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :recipe_step do
    recipe
    body "Instructions"
    sequence(:order)
  end
  factory :recipe_category do
    recipe
    category
  end

  factory :recipe do
    sequence(:name) { |n| "recipe#{n}" }
    user

    factory :recipe_shared do
      shared true
    end

    factory :recipe_numbers do
      cooking_time { rand(5..60) }
      num_served_min { rand(1..4) }
      num_served_max { rand(5..8) }
      complexity { rand(1..3) }

      factory :recipe_complete do
        transient do
          recipe_steps_count { rand(4..8) }
          ingredient_lists_count { rand(5..15) }
          categories_count { rand(1..3) }
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
            step: rand(1..evaluator.recipe_steps_count))
          create_list(
            :recipe_category,
            evaluator.categories_count,
            recipe: recipe)
        end
      end
    end
  end

  factory :carted_recipe do
    recipe_cart
    recipe
  end

  factory :recipe_cart do
    user

    factory :recipe_cart_filled do
      transient do
        recipes_count { rand(1..3) }
      end

      after(:create) do |recipe_cart, evaluator|
        create_list(
          :carted_recipe,
          evaluator.recipes_count,
          recipe_cart: recipe_cart)
      end
    end
  end
end
