require 'rails_helper'

feature 'user can add recipes to cart', %{
  As a user,
  I want to add recipes to my cart
  So that I can make sure I've chosen the right ones

  Acceptance criteria:
  [√] User can add recipe to cart from index page
  [√] User can add recipe to cart from show page
  [√] User is taken to recipe cart after adding a recipe
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
