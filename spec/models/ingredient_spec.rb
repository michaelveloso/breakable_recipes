require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  it { should have_valid(:name).when("tomatoes", "soy sauce") }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:subtype).when("plum", "red wine") }

  it 'should not validate duplicate name-subtype pairs' do
    Ingredient.create(name: "Tomatoes", subtype: "Plum")
    ingredient_invalid = Ingredient.new(name: "Tomatoes", subtype: "Plum")
    expect(ingredient_invalid.valid?).to eq(false)
  end

end
