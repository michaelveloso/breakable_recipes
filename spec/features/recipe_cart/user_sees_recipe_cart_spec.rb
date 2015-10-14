require 'rails_helper'

feature 'user can add recipes to cart', %{
  As a user,
  I want to add recipes to my cart
  So that I can make sure I've chosen the right ones

  Acceptance criteria:
  [√] User can click on 'Recipe Cart' button in topbar
  [√] User sees recipes in cart
  [] Recipes are links to their show pages
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe_complete, user: @user)
    @recipe_2 = FactoryGirl.create(:recipe_complete, user: @user)
    FactoryGirl.create(:carted_recipe, recipe_cart: @user.cart, recipe: @recipe_1)
    FactoryGirl.create(:carted_recipe, recipe_cart: @user.cart, recipe: @recipe_2)
    sign_in(@user)
  end

  scenario 'user can navigate to cart from topbar' do
    click_link 'My Recipe Cart'

    expect(current_path).to eq('/recipe_cart')
  end

  scenario 'user can see all recipes in cart' do
    visit '/recipe_cart'

    expect(page).to have_content(@recipe_1.name)
    expect(page).to have_content(@recipe_2.name)
  end

  scenario 'recipes are links to their show pages' do
    visit '/recipe_cart'

    click_link(@recipe_1.name)

    expect(current_path).to eq(recipe_path(@recipe_1))
    visit '/recipe_cart'

    click_link(@recipe_2.name)

    expect(current_path).to eq(recipe_path(@recipe_2))
  end

end
