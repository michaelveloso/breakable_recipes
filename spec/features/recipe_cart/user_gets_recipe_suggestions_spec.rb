require 'rails_helper'

feature 'user gets suggestions from shopping list', %{
  As a user,
  I want to get suggestions for more recipes
  So that I can don't waste ingredients

  Acceptance criteria:
  [] User can choose ingredients from shopping list page
  [] User sees list of suggested recipes
  [] Suggested recipes are links to their show page
  [] Suggested recipes do not include recipes already in cart
  [] If no suggestions, user is informed
  [] Page includes links to recipe index and shopping cart
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe, user: @user, name: "Test Recipe 1")
    @recipe_2 = FactoryGirl.create(:recipe, user: @user, name: "Test Recipe 2")
    @ingredient_1 = FactoryGirl.create(:ingredient, name: "Ingredient 1")
    @ingredient_2 = FactoryGirl.create(:ingredient, name: "Ingredient 2")
    @ingredient_3 = FactoryGirl.create(:ingredient, name: "Ingredient 3")
    FactoryGirl.create(:ingredient_list, ingredient: @ingredient_1, recipe: @recipe_1)
    FactoryGirl.create(:ingredient_list, ingredient: @ingredient_2, recipe: @recipe_1)
    FactoryGirl.create(:ingredient_list, ingredient: @ingredient_2, recipe: @recipe_2)
    FactoryGirl.create(:ingredient_list, ingredient: @ingredient_3, recipe: @recipe_2)
    @user.cart.recipes << @recipe_1
    sign_in(@user)
    visit shopping_list_path
  end

  scenario 'user is shown error if no ingredients are chosen' do
    click_button "Get suggested recipes"

    expect(current_path).to eq(shopping_list_path)
    expect(page).to have_content("No ingredients tagged!")
  end

  scenario 'user can choose ingredients from shopping list page' do
    page.check("id[#{@ingredient_1.id}]")
    page.check("id[#{@ingredient_2.id}]")
  end

  scenario 'user sees list of suggested recipes' do
    page.check("id[#{@ingredient_2.id}]")
    click_button "Get suggested recipes"

    expect(current_path).to eq(suggested_recipe_path)
    expect(page).to have_content(@recipe_2.name)
  end

  scenario 'suggested recipes are links to their show pages' do
    page.check("id[#{@ingredient_2.id}]")
    click_button "Get suggested recipes"

    click_link @recipe_2.name

    expect(current_path).to eq(recipe_path(@recipe_2))
  end

  scenario 'suggested recipes do not include recipes already in cart' do
    page.check("id[#{@ingredient_2.id}]")
    click_button "Get suggested recipes"

    expect(page).to_not have_content(@recipe_1.name)
  end

  scenario 'If no suggestions, user is informed' do
    page.check("id[#{@ingredient_1.id}]")
    click_button "Get suggested recipes"

    expect(page).to have_content("No matches found.")
  end

  scenario 'Page includes links to recipe index and shopping cart' do
    page.check("id[#{@ingredient_1.id}]")
    click_button "Get suggested recipes"

    click_button 'Back to recipes'

    expect(current_path).to eq(recipes_path)

    visit shopping_list_path

    page.check("id[#{@ingredient_1.id}]")
    click_button "Get suggested recipes"

    click_button 'Back to cart'

    expect(current_path).to eq(recipe_cart_path)
  end
end
