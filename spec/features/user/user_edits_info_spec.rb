require 'rails_helper'

feature 'user edits info', %Q{
  As a user,
  I want to edit my information
  So I can keep it up to date

  Acceptance criteria:

  [] User can edit info from show page
  [] No other users can edit a user's show page
  [] User can change username, email, first_name, last_name, and password
  [] User is shown errors if mandatory fields are not filled out
  [] User is shown errors if duplicate username
  [] User is shown errors if duplicate email
  [] User is shown errors if password is incorrect
  [] User is shown message if form is filled out correctly
  [] User is taken to user show page when form is filled out correctly
} do

  context 'user owns edit page' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      visit user_path(@user)
    end

    scenario 'Can edit info from show page' do
      click_button 'Edit your info'

      expect(page).to have_content('Update your info')
      expect(current_path).to eq(edit_user_registration_path(@user))
    end

    scenario 'correct update provides success message on show page' do
      visit edit_user_registration_path(@user)

      fill_in 'First name', with: "Firsty"
      fill_in 'Last name', with: "Lasty"
      fill_in 'Username', with: "New username"
      fill_in 'Email', with: "New@email.com"
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      fill_in 'Current password', with: @user.password
      click_button 'Save your changes'

      visit user_path(@user)
      save_and_open_page
      expect(page).to have_content("New username")
      expect(page).to have_content("New@email.com")
      expect(page).to have_content("Firsty Lasty")
    end

    scenario "username can't be blank" do
      fill_in 'Username', with: nil
      click_button 'Save your changes'

      expect(page).to have_content("Username can't be blank")
    end

    scenario "email can't be blank" do
      fill_in 'Email', with: nil
      click_button 'Save your changes'

      expect(page).to have_content("Email can't be blank")
    end

    scenario "password must be at least 8 characters" do
      fill_in 'Password', with: 'pass'
      fill_in 'Password confirmation', with: 'pass'
      fill_in 'Current password', with: @user.password
      click_button 'Save your changes'

      expect(page).to have_content(
        'Password is too short (minimum is 8 characters)')
    end

    scenario "username can't be a dupe" do
      user = FactoryGirl.create(:user)
      fill_in 'Username', with: user.username
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      fill_in 'Current password', with: @user.password
      click_button 'Save your changes'

      expect(page).to have_content('Username has already been taken')
    end

    scenario "email can't be a dupe" do
      user = FactoryGirl.create(:user)
      fill_in 'Email', with: user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      fill_in 'Current password', with: @user.password
      click_button 'Save your changes'

      expect(page).to have_content('Email has already been taken')
    end
  end
end
