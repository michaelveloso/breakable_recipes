require 'rails_helper'

feature 'user can add categories', %{
  As a user,
  I want to add categories to a recipe
  So that I can know what kind of recipe it is

  Acceptance criteria:

  [] Form displays dropdowns for categories
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @category1 = FactoryGirl.create(:category)
    @category2 = FactoryGirl.create(:category)
    sign_in(@user)

    visit new_recipe_path
  end

  scenario 'user can add categories to a new recipe' do
    fill_in "recipe-name-input", with: "Recipe Name"
    select @category1.name, from: 'recipe_categories_attributes_0_id'
    select @category2.name, from: 'recipe_categories_attributes_1_id'
    click_button("Add this Recipe!")

    expect(page).to have_content("Recipe added!")
    expect(current_path).to eq(recipe_path(Recipe.last))
  end

  scenario 'categories appear on recipe show page' do
    fill_in "recipe-name-input", with: "Recipe Name"
    select @category1.name, from: 'recipe_categories_attributes_0_id'
    select @category2.name, from: 'recipe_categories_attributes_1_id'
    click_button("Add this Recipe!")

    expect(page).to have_content(@category1.name)
    expect(page).to have_content(@category2.name)
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
