require 'rails_helper'

feature 'user can remove recipes from cart', %{
  As a user,
  I want to remove recipes from my cart
  So I can decide I don't want to make a particular recipe

  Acceptance criteria:

  [√] User can remove recipes from recipe cart
  [√] User can clear all recipes at once
  [√] User is notified on successful removal

} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe_complete, user: @user)
    @recipe_2 = FactoryGirl.create(:recipe_complete, user: @user)
    FactoryGirl.create(
      :carted_recipe,
      recipe_cart: @user.cart,
      recipe: @recipe_1)
    FactoryGirl.create(
      :carted_recipe,
      recipe_cart: @user.cart,
      recipe: @recipe_2)
    sign_in(@user)

    visit recipe_cart_path
  end

  scenario 'user can remove recipes from recipe cart' do
    click_button('Remove from cart', match: :first)

    expect(page).to_not have_link(@recipe_1.name)
    expect(page).to have_content(@recipe_2.name)
  end

  scenario 'user can remove all recipes in cart' do
    click_button('Clear cart')

    expect(page).to_not have_content(@recipe_1.name)
    expect(page).to_not have_content(@recipe_2.name)
  end

  scenario 'user is notified on successful removal' do
    click_button('Remove from cart', match: :first)

    expect(page).to have_content("#{@recipe_1.name} removed from cart!")
  end

  scenario 'user is notified on successful clear' do
    click_button('Clear cart')

    expect(page).to have_content("All recipes cleared!")
  end
end
