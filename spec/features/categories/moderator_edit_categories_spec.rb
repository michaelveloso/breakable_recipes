require 'rails_helper'

feature 'user edits categories', %{
  As a privileged user
  I want edit categories
  So I can fix mistakes

  Acceptance criteria:

  [] - Moderator can edit categories from category index
  [] - Edit page shows all fields
  [] - User sees success message on update
  [] - User is taken to categories index on update
  [] - User is shown errors on unsuccessful update
} do

  before(:each) do
    @category = FactoryGirl.create(:category)
    @member = FactoryGirl.create(:user)
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
  end

  scenario 'only moderator or admin can edit categories' do
    sign_in(@mod)
    visit categories_path

    click_button 'Edit'
    expect(page).to have_content("Edit this category")
    expect(page).to_not have_content("You don't have permission")
    click_link 'Sign Out'

    sign_in(@admin)
    visit categories_path

    click_button 'Edit'
    expect(page).to have_content("Edit this category")
    expect(page).to_not have_content("You don't have permission")
  end

  scenario 'edit page shows all fields' do
    sign_in(@mod)
    visit edit_category_path(@category)

    find_field 'edit-category-field'
  end

  scenario 'user sees success message on update' do
    sign_in(@mod)
    visit edit_category_path(@category)

    fill_in 'edit-category-field', with: 'New Category'
    click_button 'Submit'

    expect(page).to have_content("Category edited")
  end

  scenario 'user is taken to categories index on update' do
    sign_in(@mod)
    visit edit_category_path(@category)

    fill_in 'edit-category-field', with: 'New Category'
    click_button 'Submit'

    expect(current_path).to eq(categories_path)
    expect(page).to have_content('New Category')
  end

  scenario 'user is shown errors if name is blank' do
    sign_in(@mod)
    visit edit_category_path(@category)

    fill_in 'edit-category-field', with: ''
    click_button 'Submit'

    expect(page).to have_content('Name can\'t be blank')
  end

  scenario 'user is shown errors if name is duplicate' do
    new_category = FactoryGirl.create(:category)
    sign_in(@mod)
    visit edit_category_path(new_category)

    fill_in 'edit-category-field', with: @category.name
    click_button 'Submit'

    expect(page).to have_content('Name has already been taken')
  end
end

def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'
end
