require 'rails_helper'

feature 'moderator edits ingredient', %{
  As a moderator
  I want to edit an ingredient
  To fix mistakes

  Acceptance criteria:

  [√] - Moderator can edit ingredients from ingredients index
  [√] - Admin can edit ingredients from ingredients index
  [√] - Form shows all fields
  [√] - Successful submission takes user to ingredients index
  [√] - Successful submission shows success message
  [√] - Unsuccessful submission shows errors
  [√] - Users cannot edit ingredients from ingredients index
  [√] - Users cannot visit edit ingredient page without permission

} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @moderator = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
    @ingredient = FactoryGirl.create(:ingredient_subtype)
  end

  context 'user has permission' do

    scenario 'only authorized user can access edit button on ingredient index' do
      sign_in(@moderator)

      visit ingredients_path
      click_button ('Edit')

      expect(current_path).to eq(edit_ingredient_path(@ingredient))
      click_link ('Sign Out')

      sign_in(@admin)
      visit ingredients_path
      click_button ('Edit')

      expect(current_path).to eq(edit_ingredient_path(@ingredient))
      click_link ('Sign Out')

      sign_in(@user)

      visit ingredients_path
      expect(page.has_button?('Edit')).to eq(false)
    end

    scenario 'form fields are visible and prefilled' do
      sign_in(@moderator)
      visit edit_ingredient_path(@ingredient)

      find_field 'ingredient-name-input'
      find_field 'ingredient-subtype-input'
      expect(page).to have_field('ingredient-name-input', with: @ingredient.name)
      expect(page).to have_field('ingredient-subtype-input', with: @ingredient.subtype)
    end

    scenario 'moderator can edit ingredients' do
      sign_in(@moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Update this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'admin can edit ingredients' do
      sign_in(@admin)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Update this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'successful submission updates database' do
      sign_in(@moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'heirloom'
      click_button('Update this ingredient')

      @ingredient.reload
      expect(@ingredient.name).to eq('Tomatillos')
      expect(@ingredient.subtype).to eq('heirloom')
    end

    scenario 'successful submission shows success on ingredient index' do
      sign_in(@moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'heirloom'
      click_button('Update this ingredient')

      expect(page).to have_content('Ingredient updated!')
      expect(page).to have_content('Tomatillos, heirloom')
      expect(current_path).to eq(ingredients_path)
    end

    scenario 'unsuccessful submission shows errors' do
      sign_in(@moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: ''
      fill_in 'ingredient-subtype-input', with: ''
      click_button('Update this ingredient')

      expect(page).to have_content('Name can\'t be blank')
    end
  end

  context 'user does not have permission' do

    scenario 'user cannot visit edit page' do
      sign_in(@user)
      visit edit_ingredient_path(@ingredient)

      expect(current_path).to eq(ingredients_path)
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
