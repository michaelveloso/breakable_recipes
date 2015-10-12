require 'rails_helper'

feature 'user can add ingredients', %{
  As a user,
  I want to add ingredients to a recipe
  So that I know what ingredients I need

  Acceptance criteria:

  [√] User can add more ingredient fields
  [√] Form displays dropdowns for ingredients
  [√] Form allows associated step
  [√] Correct ingredients appear on show page
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @ingredient1 = FactoryGirl.create(:ingredient)
    @ingredient2 = FactoryGirl.create(:ingredient)
    @ingredient3 = FactoryGirl.create(:ingredient)
    sign_in(@user)

    visit new_recipe_path
    fill_in "recipe-name-input", with: "Recipe Name"
  end

  scenario 'user can add more ingredient fields', js: true do
    expect(
      page.has_select?('recipe_ingredient_lists_attributes_0_id')).to eq(true)
    expect(
      page.has_select?('recipe_ingredient_lists_attributes_1_id')).to eq(false)
    click_button 'new-ingredient-button'
    expect(
      page.has_select?('recipe_ingredient_lists_attributes_1_id')).to eq(true)
  end

  scenario 'user can add ingredients to a new recipe', js: true do
    click_button 'new-ingredient-button'
    click_button 'new-ingredient-button'
    select @ingredient1.name, from: 'recipe_ingredient_lists_attributes_0_id'
    select @ingredient2.name, from: 'recipe_ingredient_lists_attributes_1_id'
    select @ingredient3.name, from: 'recipe_ingredient_lists_attributes_2_id'
    click_button("Add this Recipe!")

    expect(page).to have_content("Recipe added!")
  end

  scenario 'user can add amount to ingredients' do
    select @ingredient1.name, from: 'recipe_ingredient_lists_attributes_0_id'
    fill_in 'recipe_ingredient_lists_attributes_0_amount', with: "ing amount"
    click_button("Add this Recipe!")

    expect(page).to have_content("ing amount")
  end

  scenario 'user can add preparation to ingredients' do
    select @ingredient1.name, from: 'recipe_ingredient_lists_attributes_0_id'
    fill_in 'recipe_ingredient_lists_attributes_0_preparation',
      with: "some preparation"
    click_button("Add this Recipe!")

    expect(page).to have_content("some preparation")
  end

  scenario 'user can tag ingredients with step order', js: true do
    click_button 'new-ingredient-button'
    select @ingredient1.name, from: 'recipe_ingredient_lists_attributes_0_id'
    fill_in 'recipe_ingredient_lists_attributes_0_step', with: 1
    select @ingredient2.name, from: 'recipe_ingredient_lists_attributes_1_id'

    click_button("Add this Recipe!")

    expect(page).to have_content("Recipe added!")
    expect(current_path).to eq(recipe_path(Recipe.last))
  end

  scenario 'ingredients appear on recipe show page', js: true do
    click_button 'new-ingredient-button'
    select @ingredient1.name, from: 'recipe_ingredient_lists_attributes_0_id'
    select @ingredient2.name, from: 'recipe_ingredient_lists_attributes_1_id'
    click_button("Add this Recipe!")

    expect(page).to have_content(@ingredient1.name)
    expect(page).to have_content(@ingredient2.name)
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
