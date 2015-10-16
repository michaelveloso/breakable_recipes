require 'rails_helper'

feature 'admin can delete user from index', %{
  As an admin,
  I want to delete a user from the index
  So I can get rid of trolls

  Acceptance criteria:

  [√] - Admin sees delete button on users index page
  [√] - Admin sees confirmation after delete
} do

  before(:each) do
    @member = FactoryGirl.create(:user)
    @mod = FactoryGirl.create(:user_mod)
    @admin = FactoryGirl.create(:user_admin)
    sign_in(@admin)

    visit admin_users_path
  end

  scenario 'Admin can delete users from index' do
    click_button('Delete', match: :first)

    expect(page).to_not have_content("#{@member.username}, #{@member.email}")
  end

  scenario 'Admin sees confirmation after delete' do
    click_button('Delete', match: :first)

    expect(page).to have_content("#{@member.username} deleted")
  end
end
