require 'rails_helper'

feature 'admin can set privileges', %{
  As an admin,
  I want to set privileges for other users
  So I can control who has what privileges

  Acceptance criteria:

  [] - Admin sees appropriate buttons
  [√] - Admin can make moderator from user's show page
  [√] - Admin can make admin from user's show page
  [√] - Admin can remove all privilege from user's show page
  [√] - Admin is given confirmation when privilege is changed
  [] - User is notified via email when privilege is changed
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
    sign_in(@admin)
  end

  scenario "Admin sees appropriate buttons" do
    visit admin_user_path(@user)

    expect(page.has_button?('Make member')).to eq(false)
    find_button('Make moderator')
    find_button('Make admin')

    visit admin_user_path(@mod)

    expect(page.has_button?('Make moderator')).to eq(false)
    find_button('Make member')
    find_button('Make admin')

    visit admin_user_path(@admin)

    expect(page.has_button?('Make admin')).to eq(false)
    find_button('Make moderator')
    find_button('Make member')
  end

  scenario "Admin can elevate a member to a moderator" do
    visit admin_user_path(@user)

    click_button('Make moderator')
    expect(@user.reload.role).to eq('moderator')
  end

  scenario "Admin can elevate a member to admin" do
    visit admin_user_path(@user)

    click_button('Make admin')

    expect(@user.reload.role).to eq('admin')
  end

  scenario "Admin can elevate a moderator to admin" do
    visit admin_user_path(@mod)

    click_button('Make admin')

    expect(@mod.reload.role).to eq('admin')
  end

  scenario "Admin can demote moderator to member" do
    visit admin_user_path(@mod)

    click_button('Make member')

    expect(@mod.reload.role).to eq('member')
  end

  scenario "Admin can demote admin to moderator" do
    admin = FactoryGirl.create(:user_admin)
    visit admin_user_path(admin)

    click_button('Make moderator')

    expect(admin.reload.role).to eq('moderator')
  end

  scenario "Admin can demote admin to member" do
    admin = FactoryGirl.create(:user_admin)
    visit admin_user_path(admin)

    click_button('Make member')

    expect(admin.reload.role).to eq('member')
  end

  scenario "Admin is shown notification of status change" do
    visit admin_user_path(@user)

    click_button('Make admin')

    expect(page).to have_content("#{@user.username} is now an admin")
    click_button('Make moderator')

    expect(page).to have_content("#{@user.username} is now a moderator")
    click_button('Make member')

    expect(page).to have_content("#{@user.username} is now a member")
  end

  scenario "User gets email notification of role change" do
    pending("Email not implemented yet")
    expect(true).to eq(false)
  end

end
