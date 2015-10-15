require 'rails_helper'

feature 'user gets suggestions from shopping list', %{
  As a user,
  I want to get suggestions for more recipes
  So that I can don't waste ingredients

  Acceptance criteria:
  [] User can choose ingredients from shopping list page
  [] User can click button to get suggested recipes
  [] User sees list of suggested recipes
  [] Suggested recipes do not include recipes already in cart
  [] If no suggestions, user is informed
  [] Page includes links to recipe index and shopping cart
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe_complete, user: @user)
    sign_in(@user)
  end

  scenario 'user can add recipe to cart from index' do
    visit recipes_path

    click_button "Add to cart"

    expect(@user.cart.recipes.include?(@recipe)).to eq(true)
  end

  scenario 'user can add recipe to cart from show' do
    visit recipe_path(@recipe)

    click_button "Add to cart"

    expect(@user.cart.recipes.include?(@recipe)).to eq(true)
  end

  scenario 'user is taken to recipe cart after adding a recipe' do
    visit recipe_path(@recipe)

    click_button "Add to cart"

    expect(current_path).to eq('/recipe_cart')
    expect(page).to have_content(@recipe.name)
    expect(page).to_not have_content('No recipes added!')
  end

end
