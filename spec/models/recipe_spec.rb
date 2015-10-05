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
    FactoryGirl.create(:recipe, name: "Recipe")
    new_recipe = FactoryGirl.build(:recipe, name: "Recipe")
    expect(new_recipe.valid?).to eq(false)
  end

  it 'should default to 0 on numerical values' do
    recipe = FactoryGirl.create(:recipe)
    expect(recipe.cooking_time).to eq(0)
    expect(recipe.num_served_min).to eq(0)
    expect(recipe.num_served_max).to eq(0)
    expect(recipe.complexity).to eq(0)
  end

  it 'should default to empty strings on 0 values' do
    recipe = FactoryGirl.create(:recipe)
    expect(recipe.complexity_rating).to eq("")
    expect(recipe.cooking_time_min).to eq("")
    expect(recipe.num_served).to eq("")
  end

  it 'should show rating strings' do
    recipe = FactoryGirl.create(:recipe_numbers)
    expect(recipe.complexity_rating).to eq(recipe.complexity)
    expect(recipe.cooking_time_min).to eq("#{recipe.cooking_time} minutes")
    expect(recipe.num_served).to eq("#{recipe.num_served_min}-#{recipe.num_served_max} people")
  end
end
