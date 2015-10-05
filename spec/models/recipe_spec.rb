require 'rails_helper'

RSpec.describe Recipe, type: :model do

  it { should belong_to :user }
  it { should have_many :recipe_categories }
  it { should have_many :recipe_steps }
  it { should have_many :ingredient_lists }
  it { should have_many :ingredients }
  it { should have_many :categories }

  it { should have_valid(:name).when("tomatoes", "soy sauce") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:cooking_time).when('0', '30', '200') }
  it { should_not have_valid(:cooking_time).when('bob', '-5', '20.5') }

  it { should have_valid(:num_served_min).when('0', '5', '8') }
  it { should_not have_valid(:num_served_min).when('bob', '-5', '20.5') }

  it { should have_valid(:num_served_max).when('0', '5', '8') }
  it { should_not have_valid(:num_served_max).when('bob', '-5', '20.5') }

  it { should have_valid(:complexity).when('0', '1', '2', '3') }
  it { should_not have_valid(:num_served_max).when('bob', '-1', '20.5') }

  it 'should not accept duplicate names' do
    user = FactoryGirl.create(:user)
    Recipe.create(name: "Recipe", user: user)
    new_recipe = Recipe.new(name: "Recipe", user: user)
    expect(new_recipe.valid?).to eq(false)
  end

  it 'should default to 0 on numerical values' do
    user = FactoryGirl.create(:user)
    recipe = Recipe.create(name: "Recipe", user: user)
    expect(recipe.cooking_time).to eq(0)
    expect(recipe.num_served_min).to eq(0)
    expect(recipe.num_served_max).to eq(0)
    expect(recipe.complexity).to eq(0)
  end
end
