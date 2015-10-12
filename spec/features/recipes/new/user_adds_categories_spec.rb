require 'rails_helper'

feature 'user can add categories', %{
  As a user,
  I want to add categories to a recipe
  So that I can know what kind of recipe it is

  Acceptance criteria:

  [√] User can add more category fields
  [√] Form displays dropdowns for categories
  [√] Correct categories appear on show page
} do

  before(:each) do
    @category1 = FactoryGirl.create(:category)
    @category2 = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    sign_in(@user)
    visit new_recipe_path
  end

  scenario 'user can add category fields to forms', js: true do
    expect(page.has_select?('recipe_categories_attributes_0_id')).to eq(true)
    expect(page.has_select?('recipe_categories_attributes_1_id')).to eq(false)
    click_button 'new-category-button'
    expect(page.has_select?('recipe_categories_attributes_1_id')).to eq(true)
  end

  scenario 'user can add categories to a new recipe', js: true do
    fill_in "recipe-name-input", with: "Recipe Name"
    select @category1.name, from: 'recipe_categories_attributes_0_id'
    click_button 'new-category-button'
    select @category2.name, from: 'recipe_categories_attributes_1_id'
    click_button("Add this Recipe!")

    expect(page).to have_content("Recipe added!")
    expect(current_path).to eq(recipe_path(Recipe.last))
  end

  scenario 'categories appear on recipe show page', js: true do
    fill_in "recipe-name-input", with: "Recipe Name"
    select @category1.name, from: 'recipe_categories_attributes_0_id'
    click_button 'new-category-button'
    select @category2.name, from: 'recipe_categories_attributes_1_id'
    click_button("Add this Recipe!")

    expect(page).to have_content(@category1.name)
    expect(page).to have_content(@category2.name)
  end
end
