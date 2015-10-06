require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  it { should have_valid(:name).when("tomatoes", "soy sauce") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:subtype).when("plum", "red wine") }

  it { should have_many :ingredient_lists }
  it { should have_many :recipes }

  it 'should not validate duplicate name-subtype pairs' do
    Ingredient.create(name: "Tomatoes", subtype: "Plum")
    ingredient_invalid = Ingredient.new(name: "Tomatoes", subtype: "Plum")
    expect(ingredient_invalid.valid?).to eq(false)
  end

  it 'should give its description' do
    ingredient = Ingredient.create(name: "Tomatoes", subtype: "Plum")
    expect(ingredient.to_s).to eq("Plum Tomatoes")
  end
end
