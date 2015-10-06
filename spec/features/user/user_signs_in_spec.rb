require 'rails_helper'

feature 'user signs in', %Q{
  As a signed up user
  I want to sign in
  So that I can regain access to my account

  Acceptance criteria:

  [] - User is taken to their recipe index after successful sign-in
} do
  context 'valid credentials' do

    before(:each) do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario 'user recieves confirmation' do
      expect(page).to have_content('Signed in successfully')
      expect(page).to have_content('Sign Out')
    end

    scenario 'user is taken to their index' do
      expect(current_path).to eq(recipes_path)
    end
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_button 'Log in'
    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end
end
