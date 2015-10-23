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

  before(:each) do
    @user = FactoryGirl.create(:user)
    @moderator = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
  end

  context 'user has permission' do

    scenario 'moderator can see input fields' do
      sign_in(@moderator)

      visit ingredients_path
      find_field 'ingredient-name-input'
      find_field 'ingredient-subtype-input'
    end

    scenario 'moderator can add ingredients' do
      sign_in(@moderator)
      visit ingredients_path
      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Add this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'admin can add ingredients' do
      sign_in(@admin)
      visit ingredients_path

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Add this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'successful submission shows success on ingredient index' do
      sign_in(@moderator)
      visit ingredients_path

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'Heirloom'

      click_button('Add this ingredient')

      expect(page).to have_content('Ingredient added!')
      expect(page).to have_content('Tomatillos, Heirloom')
      expect(current_path).to eq(ingredients_path)
    end

    scenario 'unsuccessful submission shows errors' do
      sign_in(@moderator)
      visit ingredients_path
      click_button('Add this ingredient')
      expect(page).to have_content('Name can\'t be blank')
    end
  end

  context 'user does not have permission' do

    scenario 'user visit new ingredient page from index' do
      sign_in(@user)
      visit ingredients_path

      expect(page).to_not have_content('Add this ingredient')
    end
  end
end
