require 'rails_helper'

feature 'admin can see index of users', %{
  As an admin,
  I want to see a list of users
  So I know who has access to the site

  Acceptance criteria:

  [√] - Admin can visit list of users at admin/users from topbar link
  [√] - Index of users shows role
  [√] - Mod cannot see link or visit admin_users_path
  [√] - Member cannot see link or visit admin_users_path
  [] - Usernames are links to user show pages
} do

  before(:each) do
    @member = FactoryGirl.create(:user)
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
  end

  scenario 'Admin can visit list of users from topbar link' do
    sign_in(@admin)

    click_link 'Users'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content(@member.username)
    expect(page).to have_content(@member.email)
    expect(page).to have_content(@mod.username)
    expect(page).to have_content(@mod.email)
    expect(page).to have_content(@admin.username)
    expect(page).to have_content(@admin.email)
  end

  scenario 'Users index shows role of each user' do
    sign_in(@admin)

    visit admin_users_path

    expect(page).to have_content("#{@mod.username} #{@mod.email} (moderator)")
    expect(page).to have_content("#{@admin.username} #{@admin.email} (admin)")
  end

  scenario 'Moderator cannot see link or visit admin_users_path' do
    sign_in(@mod)

    expect(page.has_link?('Users')).to eq(false)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have permission to do that")
  end

  scenario 'Member cannot see link or visit admin_users_path' do
    sign_in(@member)

    expect(page.has_link?('Users')).to eq(false)
    visit admin_users_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have permission to do that")
  end

  scenario 'Usernames are links to their user show pages' do
    sign_in(@admin)

    visit admin_users_path

    click_link(@member.username)

    expect(current_path).to eq(admin_user_path(@member))
    visit admin_users_path

    click_link(@mod.username)

    expect(current_path).to eq(admin_user_path(@mod))
  end
end
