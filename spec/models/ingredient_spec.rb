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

  it 'should yield a string' do
    ingredient = Ingredient.create(name: "Tomatoes", subtype: "Plum")
    expect(ingredient.to_s).to eq("Plum Tomatoes")
  end

  it 'should give a dropdown-friendly output' do
    ingredient = Ingredient.create(name: "Tomatoes", subtype: "Plum")
    expect(ingredient.for_dropdown).to eq("Tomatoes, Plum")
  end

  it 'should offer all categories as options' do
    Ingredient.create(name: "Basil")
    Ingredient.create(name: "Noodles", subtype: "Rice")
    basil_id = Ingredient.where(name: "Basil")[0].id
    rice_noodles_id = Ingredient.where(name: "Noodles")[0].id
    ingredient_options = Ingredient.options_for_select
    expect(ingredient_options).to be_a(Array)
    expect(ingredient_options[0]).to eq(["(Choose an ingredient)", nil])
    expect(ingredient_options.include?(["Basil", basil_id])).to eq(true)
    expect(ingredient_options.include?(["Noodles, Rice", rice_noodles_id])).to eq(true)
  end
end
