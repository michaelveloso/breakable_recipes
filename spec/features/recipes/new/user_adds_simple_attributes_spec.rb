require 'rails_helper'

feature 'user can add simple attributes', %{
  As a user,
  I want to add basic recipe attributes
  So that I can store them for later

  Acceptance criteria:

  [√] User can create new recipes from recipe index
  [√] Form is only visible to registered users
  [√] Form displays fields for recipe name,
       cooking time, complexity, and number served
  [√] Form requires name only
  [√] Form displays success message on complete submission
  [√] User sees recipe show page on complete submission
  [√] Form shows errors on incomplete submission
} do

  context 'unregistered user' do

    scenario 'only registered user can visit new recipe path' do
      visit new_recipe_path
      expect(page).to have_content("You need to sign in or sign up")
    end
  end

  context 'registered user' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      visit new_recipe_path
    end

    scenario 'user can visit new recipe page from recipe index' do
      visit recipes_path

      click_button("Add a new recipe")

      expect(current_path).to eq(new_recipe_path)
    end

    scenario 'user can see form fields' do
      find_field("recipe-name-input")
      find_field("recipe_cooking_time")
      find_field("Complexity")
      find_field("num-served-min-input")
      find_field("num-served-max-input")
    end

    scenario 'user sees success message on successful submission' do
      fill_in "recipe-name-input", with: "Recipe Name"
      click_button("Add this Recipe!")

      expect(page).to have_content("Recipe added!")
    end

    scenario 'user is taken to recipe show page on successful submission' do
      fill_in "recipe-name-input", with: "Recipe Name"
      click_button("Add this Recipe!")

      expect(current_path).to eq(recipe_path(Recipe.last))
    end

    scenario 'user sees error message if name is blank' do
      click_button("Add this Recipe!")

      expect(page).to have_content("Name can't be blank")
    end

    scenario 'user sees error message if user/name tuple is duplicate' do
      FactoryGirl.create(:recipe, name: "Recipe Name", user: @user)

      fill_in "recipe-name-input", with: "Recipe Name"
      click_button("Add this Recipe!")

      expect(page).to have_content("Name has already been taken")
    end
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
