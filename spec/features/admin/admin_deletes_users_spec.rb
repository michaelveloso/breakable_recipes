require 'rails_helper'

feature 'admin can delete user from index', %{
  As an admin,
  I want to delete a user from the index
  So I can get rid of trolls

  Acceptance criteria:

  [√] - Admin sees delete button on users index page
  [√] - Admin sees confirmation after delete
  [√] - All deleted user's recipes are removed
  [] - All deleted user's comments are removed
  [] - Deleted user is notified by email
} do

  before(:each) do
    @member = FactoryGirl.create(:user)
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

  scenario 'Deleted user\'s recipes are removed' do
    recipe = FactoryGirl.create(:recipe, user: @member)
    click_button('Delete', match: :first)

    expect(recipe).to_not eq(Recipe.last)
  end

  scenario 'Deleted user\'s comments are removed' do
    pending ('comments not implemented yet')
    expect(true).to eq(false)
  end

  scenario 'Deleted user is notified of deletion via email' do
    pending ('email not implemented yet')
    expect(true).to eq(false)
  end
end
