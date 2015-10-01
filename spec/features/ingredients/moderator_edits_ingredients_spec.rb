require 'rails_helper'

feature 'moderator edits ingredient', %{
  As a moderator
  I want to edit an ingredient
  To fix mistakes

  Acceptance criteria:

  [] - Moderator can edit ingredients from ingredients index
  [] - Admin can edit ingredients from ingredients index
  [] - Form shows all fields
  [] - Successful submission takes user to ingredients index
  [] - Successful submission shows success message
  [] - Unsuccessful submission shows errors
  [] - Users cannot edit ingredients from ingredients index
  [] - Users cannot visit edit ingredient page without permission

} do

  context 'user has permission' do

    before(:each) do
      @ingredient = FactoryGirl.create(:ingredient_subtype)
    end

    scenario 'authorized user can see edit button on ingredient index' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)

      visit ingredients_path
      click_button ('Edit')

      expect(current_path).to eq(edit_ingredient_path(@ingredient))
    end

    scenario 'form fields are visible and prefilled' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)

      visit edit_ingredient_path(@ingredient)

      find_field 'ingredient-name-input'
      find_field 'ingredient-subtype-input'
      expect(page).to have_field('ingredient-name-input', with: @ingredient.name)
      expect(page).to have_field('ingredient-subtype-input', with: @ingredient.subtype)
    end

    scenario 'moderator can edit ingredients' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)

      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Update this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'admin can edit ingredients' do
      admin = FactoryGirl.create(:user_admin)
      sign_in(admin)

      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      click_button('Update this ingredient')

      expect(page).to have_content('Tomatillos')
    end

    scenario 'successful submission updates database' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)

      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'heirloom'

      click_button('Update this ingredient')

      expect(Ingredient.last.name).to eq('Tomatillos')
      expect(Ingredient.last.subtype).to eq('heirloom')
    end

    scenario 'successful submission shows success on ingredient index' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: 'Tomatillos'
      fill_in 'ingredient-subtype-input', with: 'heirloom'

      click_button('Update this ingredient')

      expect(page).to have_content('Ingredient updated!')
      expect(page).to have_content('Tomatillos, heirloom')
      expect(current_path).to eq(ingredients_path)
    end

    scenario 'unsuccessful submission shows errors' do
      moderator = FactoryGirl.create(:user_mod)
      sign_in(moderator)
      visit edit_ingredient_path(@ingredient)

      fill_in 'ingredient-name-input', with: ''
      fill_in 'ingredient-subtype-input', with: ''

      click_button('Update this ingredient')
      expect(page).to have_content('Name can\'t be blank')
    end
  end

  context 'user does not have permission' do

    scenario 'user cannot visit edit ingredient page from index' do
      user = FactoryGirl.create(:user)
      sign_in(user)
      visit ingredients_path

      expect(page).to_not have_content('Edit')
    end

    scenario 'user cannot visit edit page' do
      user = FactoryGirl.create(:user)
      ingredient = FactoryGirl.create(:ingredient_subtype)
      sign_in(user)
      visit edit_ingredient_path(ingredient)

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
