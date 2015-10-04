require 'rails_helper'

feature 'user adds categories', %{
  As a privileged user
  I want to add categories
  So users have more options

  Acceptance criteria:

  [] - Moderator can add categories from at /moderator/categories
  [] - Form is displayed correctly
  [] - Form shows errors if name is not filled out correctly
  [] - Form displays success message on successful submission
  [] - Moderator is taken to categories index after success
} do

  before(:each) do
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
    sign_in(@mod)

    visit categories_path
  end

  scenario 'moderator or admin can add a category from index' do
    find_field("category-input")
    click_link 'Sign Out'

    sign_in(@admin)
    visit categories_path

    find_field("category-input")
  end

  scenario 'page shows success message on successful addition' do
    fill_in "category-input", with: "Mediterranean"
    click_button "Add a category"
    expect(page).to have_content("Category added")
  end

  scenario 'form shows error if category field is blank' do
    click_button "Add a category"
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'form shows error if duplicate name is entered' do
    FactoryGirl.create(:category, name: "Beef")
    fill_in "category-input", with: "Beef"
    click_button "Add a category"
    expect(page).to have_content("Name has already been taken")
  end

  scenario 'user stays on categories index after successful submission' do
    fill_in "category-input", with: "Mediterranean"
    click_button "Add a category"
    expect(current_path).to eq(categories_path)
  end

  scenario 'user sees new category in page' do
    fill_in "category-input", with: "Mediterranean"
    click_button "Add a category"
    expect(page).to have_content("Mediterranean")
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
