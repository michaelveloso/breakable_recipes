require 'rails_helper'

feature 'user visits account page', %{
  As a signed up user
  I want see my information
  So I can verify that it's correct

  Acceptance criteria:

  [√] - User can visit their account page by clicking 'My Account' if signed in
  [√] - User sees their information on their account page
  [√] - Users can't see other users' account pages
} do

  before(:each) do
    @user = FactoryGirl.create(:user)

    sign_in(@user)

    click_link @user.username
  end

  context 'user accesses own account' do

    scenario 'user can see their account page by clicking "My Account"' do
      expect(current_path).to eq(user_path(@user))
    end

    scenario 'user sees their information on their account page' do
      expect(page).to have_content(@user.email)
      expect(page).to have_content(@user.full_name)
      expect(page).to have_content(@user.username)
    end
  end

  scenario 'user can\'t access another user\'s account' do
    other_user = FactoryGirl.create(:user)
    visit user_path(other_user)

    expect(page).to have_content("You're not signed in as this user")
    expect(current_path).to eq(root_path)
  end
end
