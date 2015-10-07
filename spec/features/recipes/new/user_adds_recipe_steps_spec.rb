require 'rails_helper'

feature 'user can add steps', %{
  As a user,
  I want to add steps to a recipe
  So that I know how to make it

  Acceptance criteria:

  [√] Form displays body field
  [√] Recipe steps appear on show page
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in(@user)

    visit new_recipe_path
  end

  scenario 'recipe steps appear labeled in order' do
    expect("Step 1").to appear_before("Step 2")
  end

  scenario 'user can enter body for recipe steps' do
    fill_in "recipe-name-input", with: "Recipe Name"
    fill_in "recipe_recipe_steps_attributes_0_body", with: "First"
    fill_in "recipe_recipe_steps_attributes_1_body", with: "Second"
    click_button("Add this Recipe!")

    expect(page).to have_content("Recipe added!")
    expect(current_path).to eq(recipe_path(Recipe.last))
  end

  scenario 'categories appear on recipe show page' do
    fill_in "recipe-name-input", with: "Recipe Name"
    fill_in "recipe_recipe_steps_attributes_0_body", with: "First"
    fill_in "recipe_recipe_steps_attributes_1_body", with: "Second"
    click_button("Add this Recipe!")

    expect(page).to have_content("First")
    expect(page).to have_content("Second")
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
