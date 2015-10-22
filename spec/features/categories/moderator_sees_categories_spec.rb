require 'rails_helper'

feature 'user sees category index', %{
  As a privileged user
  I want see a list of categories
  So I know what's available

  Acceptance criteria:

  [√] - Moderator sees categories at /moderator/categories
  [√] - Categories are in alphabetical order
} do

  scenario 'only moderator or admin can see category list' do
    category = FactoryGirl.create(:category)
    mod = FactoryGirl.create(:user_mod)
    sign_in(mod)
    visit categories_path

    expect(page).to have_content(category.name)
    click_link 'Sign Out'

    admin = FactoryGirl.create(:user_admin)
    sign_in(admin)
    visit categories_path

    expect(page).to have_content(category.name)
    click_link 'Sign Out'

    member = FactoryGirl.create(:user)
    sign_in(member)
    visit categories_path

    expect(page).to have_content('You don\'t have permission to do that!')
    expect(current_path).to eq(root_path)
  end

  scenario 'categories are in alphabetical order' do
    mod = FactoryGirl.create(:user_mod)
    sign_in(mod)
    visit categories_path

    FactoryGirl.create(:category, name: "BBB")
    FactoryGirl.create(:category, name: "AAA")
    visit categories_path

    expect("AAA").to appear_before("BBB")
  end
end
