require 'rails_helper'

feature 'user registers', %Q{
  As a user,
  I want to sign up for an account
  So I can store my recipes

  Acceptance criteria:

  [√] User can sign up from nav bar
  [√] User must provide username, email, first_name, last_name, and password
  [√] User is shown errors if mandatory fields are not filled out
  [√] User is shown errors if duplicate username
  [√] User is shown errors if duplicate email
  [√] User is shown message if form is filled out correctly
  [√] User is taken to root when form is filled out correctly
  [√] User role is set to 'member'
} do

  scenario 'Sign Up button is visible if no one is signed in' do
    visit root_path

    find_link 'Sign Up'
  end

  context 'user provides valid information' do

    before(:each) do
      visit new_user_registration_path

      fill_in 'Username', with: 'newuser'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end

    scenario 'Gets success message on signup' do
      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_content('Sign Out')
    end

    scenario 'user is sent to root' do
      click_button 'Sign up'

      expect(current_path).to eq(root_path)
    end

    scenario 'user is set as member by default' do
      click_button 'Sign up'

      expect(User.last.role).to eq('member')
    end
  end

  context 'user fills out form incorrectly' do

    before(:each) do
      visit new_user_registration_path
    end

    scenario "fields can't be blank" do
      click_button 'Sign up'
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
    end

    scenario "photo can be blank" do
      fill_in 'Username', with: 'newuser'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    scenario "password must be at least 8 characters" do
      fill_in 'Username', with: 'newuser'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'pass'
      fill_in 'Password confirmation', with: 'pass'
      click_button 'Sign up'

      expect(page).to have_content(
        'Password is too short (minimum is 8 characters)')
    end

    scenario "username can't be a dupe" do
      user = FactoryGirl.create(:user)
      fill_in 'Username', with: user.username
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content('Username has already been taken')
    end

    scenario "email can't be a dupe" do
      user = FactoryGirl.create(:user)
      fill_in 'Username', with: 'awesomeuser'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content('Email has already been taken')
    end
  end
end
