require 'rails_helper'

feature 'user gets a shopping list', %{
  As a user,
  I want to get a shopping list
  So that I know what I need to buy

  Acceptance criteria:
  [√] User can get shopping list from recipe cart show page
  [√] User sees ingredient listed in alphabetical order
  [] Shopping cart is cleared
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

  scenario 'user can get shopping list from recipe cart show page' do
    click_button 'Make my shopping list'

    expect(current_path).to eq(shopping_list_path)
    @user.cart.shopping_list.each do |ingredient|
      expect(page).to have_content(ingredient.to_s)
    end
  end

  scenario 'ingredients are in alphabetical order' do
    click_link 'Sign Out'

    user = FactoryGirl.create(:user)
    ing_a = FactoryGirl.create(:ingredient, name: "AAA")
    ing_m = FactoryGirl.create(:ingredient, name: "MMM")
    ing_z = FactoryGirl.create(:ingredient, name: "ZZZ")
    recipe = FactoryGirl.create(:recipe, user: user)
    FactoryGirl.create(:ingredient_list, ingredient: ing_m, recipe: recipe)
    FactoryGirl.create(:ingredient_list, ingredient: ing_z, recipe: recipe)
    FactoryGirl.create(:ingredient_list, ingredient: ing_a, recipe: recipe)
    sign_in(user)

    visit recipes_path

    click_button 'Add to cart'

    click_button 'Make my shopping list'

    expect('AAA').to appear_before('MMM')
    expect('MMM').to appear_before('ZZZ')
  end

  scenario 'shopping cart is cleared when list is finalized' do
    click_button 'Make my shopping list'

    click_button 'Finalize shopping list'

    visit recipe_cart_path

    expect(page).to have_content('No recipes added')
  end
end
