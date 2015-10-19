require 'rails_helper'

feature 'admin can see index of users', %{
  As an admin,
  I want to see user's show page
  So I can examine their information

  Acceptance criteria:

  [] - Admin can visit user from users index
  [] - Non-admins cannot visit user pages
  [] - User page shows all information
} do

  before(:each) do
    @member = FactoryGirl.create(:user)
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
  end

  scenario 'Admin can visit user show page' do
    sign_in(@admin)

    visit admin_user_path(@member)

    expect(page).
      to_not have_content("You don't have permission to do that")
  end

  scenario 'Moderators cannot visit user pages' do
    sign_in(@mod)

    visit admin_user_path(@member)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have permission to do that")
  end

  scenario 'Moderators cannot visit user pages' do
    sign_in(@member)

    visit admin_user_path(@mod)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have permission to do that")
  end

  scenario 'User page shows username, email, and timestamps' do
    sign_in(@admin)

    visit admin_user_path(@member)

    expect(page).to have_content(@member.full_name)
    expect(page).to have_content(@member.username)
    expect(page).to have_content(@member.email)
    expect(page).to have_content("Joined: #{@member.created_at}")
    expect(page).to have_content("Last sign-in: #{@member.last_sign_in_at}")
  end
end
