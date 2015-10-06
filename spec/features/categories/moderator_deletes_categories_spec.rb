require 'rails_helper'

feature 'user deletes categories', %{
  As a privileged user
  I want to delete categories
  So I can keep categories focused

  Acceptance criteria:

  [√] - Moderator can delete categories at /moderator/categories
  [√] - Form displays success message on successful deletion
} do

  before(:each) do
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
    @category = FactoryGirl.create(:category)
    sign_in(@mod)

    visit categories_path
  end

  scenario 'moderator or admin can delete a category from index' do
    find_button("Delete")
    click_link 'Sign Out'

    sign_in(@admin)
    visit categories_path

    find_button("Delete")
  end

  scenario 'page shows success message on successful deletion' do
    click_button "Delete"
    expect(page).to have_content("Category deleted!")
    expect(page).to_not have_content(@category.name)
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
