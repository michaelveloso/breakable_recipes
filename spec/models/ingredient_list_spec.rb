require 'rails_helper'

RSpec.describe IngredientList, type: :model do

  it { should belong_to :ingredient }
  it { should belong_to :recipe }

  it { should have_valid(:amount).when("2 tablespoons", "4 cups") }

  it { should have_valid(:preparation).when("2 tablespoons", "4 cups") }

  it { should have_valid(:step).when(nil, "1", "9") }
  it { should_not have_valid(:step).when("bob", "-9", "1.1") }

  it 'should give its full description' do
    ingredient = FactoryGirl.create(:ingredient_subtype)
    recipe = FactoryGirl.create(:recipe)
    il = IngredientList.create(
      ingredient: ingredient,
      recipe: recipe,
      amount: "amount",
      preparation: "preparation",
      step: 5)
    expect(il.to_s).to eq("amount #{ingredient}, preparation")
  end
end
