require 'rails_helper'

feature 'moderator adds ingredient', %{
  As a moderator
  I want add to the list of ingredients
  So I can expand what users can choose from

  Acceptance criteria:

  [√] - Moderator can add ingredients from ingredients index
  [√] - Admin can add ingredients from ingredients index
  [√] - Form shows all fields
  [√] - Successful submission takes user to ingredients index
  [√] - Successful submission shows success message
  [√] - Unsuccessful submission shows errors
  [√] - Users cannot add ingredients from ingredients index
  [√] - Users cannot visit new ingredient page without permission

} do

  context 'user has permission' do

    scenario do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)

      visit new_ingredient_path
      find_field 'ingredient-name-input'
      find_field 'ingredient-subtype-input'
    end

    scenario 'moderator can add ingredients' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)
      visit ingredients_path
      click_button('Add an ingredient')
      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Add this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'admin can add ingredients' do
      admin = FactoryGirl.create(:user_admin)
      sign_in(admin)
      visit ingredients_path
      click_button('Add an ingredient')

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Add this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'successful submission shows success on ingredient index' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)
      visit ingredients_path

      click_button('Add an ingredient')

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'heirloom'

      click_button('Add this ingredient')

      expect(page).to have_content('Ingredient added!')
      expect(page).to have_content('Tomatillos, heirloom')
      expect(current_path).to eq(ingredients_path)
    end

    scenario 'unsuccessful submission shows errors' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)
      visit new_ingredient_path

      click_button('Add this ingredient')
      expect(page).to have_content('Name can\'t be blank')
    end
  end

  context 'user does not have permission' do

    scenario 'user visit new ingredient page from index' do
      user = FactoryGirl.create(:user)
      sign_in(user)
      visit ingredients_path

      expect(page).to_not have_content('Add an ingredient')
    end

    scenario 'user cannot visit add page' do
      user = FactoryGirl.create(:user)
      sign_in(user)
      visit new_ingredient_path

      expect(page).to have_content('You don\'t have permission to do that')
    end
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
