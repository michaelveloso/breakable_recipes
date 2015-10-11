require 'rails_helper'

feature 'user deletes account', %{
  As a user,
  I want to delete my account
  So I can get out if shit gets real

  Acceptance criteria:

  [√] User can delete info from account page
  [√] User gets confirmation on deletion
  [√] User is deleted
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
    visit user_path(@user)
  end

  scenario 'Can delete account from show page' do
    find_button 'Delete my account'
  end

  scenario 'Deletion shows success message' do
    click_button 'Delete my account'

    expect(page).to have_content('Account deleted!')
    expect(current_path).to eq(root_path)
  end

  scenario "Info is gone after deletion" do
    click_button 'Delete my account'

    expect(User.last).to_not eq(@user)
  end
end
