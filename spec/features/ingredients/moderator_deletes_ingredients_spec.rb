require 'rails_helper'

feature 'moderator deletes ingredient', %{
  As a moderator
  I want to delete an ingredient
  To narrow the list

  Acceptance criteria:

  [√] - Moderator can delete ingredients from ingredients index
  [√] - Admin can delete ingredients from ingredients index
  [√] - Successful deletion takes user to ingredients index
  [√] - Successful deletion shows success message
  [√] - Users cannot delete ingredients from ingredients index
} do

  context 'user has permission' do

    before(:each) do
      @member = FactoryGirl.create(:user)
      @moderator = FactoryGirl.create(:user_mod)
      @admin = FactoryGirl.create(:user_admin)
      @ingredient = FactoryGirl.create(:ingredient_subtype)
    end

    scenario 'only authorized user can see delete button on ingredient index' do
      sign_in(@moderator)
      visit ingredients_path
      find_button ('Delete')

      click_link 'Sign Out'

      sign_in(@admin)
      visit ingredients_path
      find_button ('Delete')

      click_link 'Sign Out'

      sign_in(@member)
      visit ingredients_path
      expect(page.has_button?('Delete')).to eq(false)
    end

    scenario 'moderator can delete ingredients' do
      sign_in(@moderator)

      visit ingredients_path

      click_button ('Delete')

      expect(page).to_not have_content(@ingredient.to_s)
    end

    scenario 'admin can delete ingredients' do
      sign_in(@admin)

      visit ingredients_path

      click_button ('Delete')

      expect(page).to_not have_content(@ingredient.to_s)
    end

    scenario 'successful deletion removes ingredient from database' do
      sign_in(@moderator)

      visit ingredients_path

      click_button ('Delete')

      expect(Ingredient.last).to_not eq(@ingredient)
    end

    scenario 'successful deletion shows success on ingredient index' do
      sign_in(@moderator)

      visit ingredients_path

      click_button ('Delete')

      expect(page).to have_content('Ingredient removed')
    end
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
