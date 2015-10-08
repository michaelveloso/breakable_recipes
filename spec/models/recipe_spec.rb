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

  it { should have_valid(:cooking_time).when(nil, '30', '200') }
  it { should_not have_valid(:cooking_time).when('bob', '-5', '20.5') }

  it { should have_valid(:num_served_min).when(nil, '5', '8') }
  it { should_not have_valid(:num_served_min).when('bob', '-5', '20.5') }

  it { should have_valid(:num_served_max).when(nil, '5', '8') }
  it { should_not have_valid(:num_served_max).when('bob', '-5', '20.5') }

  it { should have_valid(:complexity).when(nil, '1', '2', '3') }
  it { should_not have_valid(:num_served_max).when('bob', '-1', '20.5') }

  it 'should not accept duplicate names' do
    FactoryGirl.create(:recipe, name: "Recipe")
    new_recipe = FactoryGirl.build(:recipe, name: "Recipe")
    expect(new_recipe.valid?).to eq(false)
  end

  it 'should default to empty strings on nil values' do
    recipe = FactoryGirl.create(:recipe)
    expect(recipe.complexity_rating).to eq("")
    expect(recipe.cooking_time_min).to eq("")
    expect(recipe.num_served).to eq("")
  end

  it 'should show rating strings' do
    recipe = FactoryGirl.create(:recipe_numbers)
    expect(recipe.complexity_rating).to eq(recipe.complexity)
    expect(recipe.cooking_time_min).to eq(
      "Cooking time: #{recipe.cooking_time} minutes")
    expect(recipe.num_served).to eq(
      "Serves #{recipe.num_served_min}-#{recipe.num_served_max}")
  end
end
