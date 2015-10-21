require 'rails_helper'

feature 'user can flag recipes as shared', %{
  As a user,
  I want to flag a recipe as shared
  So that others can see it

  Acceptance criteria:

  [√] Unshared recipes can be marked as shared by owner from recipe show page
  [√] Shared recipes can be unmarked by owner form recipe show page
  [√] Owner is shown confirmation of toggle
  [] When recipes are unshared, followers are notified
  [] Unshared recipes no longer appear in followers' indexes
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    @recipe_unshared = FactoryGirl.create(
      :recipe_complete,
      user: user,
      shared: false)
    @recipe_shared = FactoryGirl.create(
      :recipe_complete,
      user: user,
      shared: true
      )
    sign_in(user)
  end

  scenario 'Unshared recipes can be shared from recipe show page' do
    visit recipe_path(@recipe_unshared)
    click_button 'Share'

    expect(@recipe_unshared.reload.shared).to eq(true)
  end

  scenario 'Shared recipes can be unshared from recipe show page' do
    visit recipe_path(@recipe_shared)
    click_button 'Unshare'

    expect(@recipe_shared.reload.shared).to eq(false)
  end

  scenario 'Owner is shown confirmation of toggle' do
    visit recipe_path(@recipe_unshared)
    click_button 'Share'

    expect(page).to have_content("#{@recipe_unshared.name} is shared!")
    visit recipe_path(@recipe_shared)

    click_button 'Unshare'

    expect(page).to have_content("#{@recipe_shared.name} is no longer shared.")
  end

  scenario 'When recipes are unshared, followers are notified' do
    pending ('Email is not yet properly set up')
    expect(true).to eq(false)
  end

  scenario 'Unshared recipes no longer appear in subscribers\' indexes' do
    pending ('Index does not include subscribed recipes yet')
    expect(true).to eq(false)
  end
end
