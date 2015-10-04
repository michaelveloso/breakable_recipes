require 'rails_helper'

feature 'user sees ingredient index', %{
  As an unauthenticated user
  I want see a list of ingredients
  So I know what's available

  Acceptance criteria:

  [√] - User sees ingredients at /ingredients
  [√] - Ingredients are in alphabetical order
} do

  scenario 'user can see ingredient list' do
    ingredient = FactoryGirl.create(:ingredient)
    visit ingredients_path

    expect(page).to have_content(ingredient.name)
  end

  scenario 'ingredients are in alphabetical order' do
    FactoryGirl.create(:ingredient, name: "BBB")
    FactoryGirl.create(:ingredient, name: "AAA")
    visit ingredients_path

    expect("AAA").to appear_before("BBB")
  end
end
