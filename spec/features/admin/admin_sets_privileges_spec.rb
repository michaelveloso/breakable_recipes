require 'rails_helper'

feature 'admin can set privileges', %{
  As an admin,
  I want to set privileges for other users
  So I can control who has what privileges

  Acceptance criteria:

  [] - Admin can make moderator from user's show page
  [] - Admin can make admin from user's show page
  [] - Admin can remove all privilege from user's show page
  [] - Admin is given confirmation when privilege is changed
  [] - User is notified via email when privilege is changed
} do

  before(:each) do
    @admin = FactoryGirl.create(:user_admin)
    sign_in(@admin)
  end

  scenario "Admin can elevate a member to a moderator" do
    user = FactoryGirl.create(:user)
    visit admin_user_path(user)

    click_button('Make moderator')

    expect(user.role).to eq('moderator')
  end

  scenario "Admin can elevate a member to admin" do
    user = FactoryGirl.create(:user)
    visit admin_user_path(user)

    click_button('Make admin')

    expect(user.role).to eq('admin')
  end

  scenario "Admin can elevate a moderator to admin" do
    mod = FactoryGirl.create(:mod)
    visit admin_user_path(mod)

    click_button('Make admin')

    expect(mod.role).to eq('admin')
  end

  scenario "Admin can demote moderator to member" do
    mod = FactoryGirl.create(:user_mod)
    visit admin_user_path(mod)

    click_button('Make member')

    expect(mod.role).to eq('member')
  end

  scenario "Admin can demote admin to moderator" do
    admin = FactoryGirl.create(:user_admin)
    visit admin_user_path(admin)

    click_button('Make moderator')

    expect(admin.role).to eq('moderator')
  end

  scenario "Admin can demote admin to member" do
    admin = FactoryGirl.create(:user_admin)
    visit admin_user_path(admin)

    click_button('Make member')

    expect(admin.role).to eq('member')
  end

  scenario "Admin is shown notification of status change" do
    user = FactoryGirl.create(:user)
    visit admin_user_path(user)

    click_button('Make admin')

    expect(page).to have_content("#{user.username} is now a admin")
    click_button('Make moderator')

    expect(page).to have_content("#{user.username} is now a moderator")
    click_button('Make member')

    expect(page).to have_content("#{user.username} is now a member")
  end

  scenario "User gets email notification of role change" do
    pending("Email not implemented yet")
    expect(true).to eq(false)
  end

end
