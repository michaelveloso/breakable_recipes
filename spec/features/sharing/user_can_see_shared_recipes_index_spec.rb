require 'rails_helper'

feature 'user can see index of shared recipes', %{
  As a user,
  I want to see a list of all shared recipes
  So that I can find new recipes

  Acceptance criteria:

  [√] User sees shared recipes at /shared/recipes
  [√] User can see show pages of shared recipes
  [√] Subscribed recipes do not appear in shared recipes
} do

  before(:each) do
    user_1 = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe_complete,
      user: user_1,
      shared: true)
    @recipe_2 = FactoryGirl.create(:recipe_complete,
      user: user_1,
      shared: true)
    sign_in(user_2)
  end

  scenario 'User sees shared recipes at /shared/recipes' do
    visit shared_recipes_path

    expect(page).to have_content(@recipe_1.name)
    expect(page).to have_content(@recipe_2.name)
  end

  scenario 'Shared recipe titles are links to their show pages' do
    visit shared_recipes_path

    click_link @recipe_1.name

    expect(page).to have_content(@recipe_1.name)
    expect(current_path).to eq(shared_recipe_path(@recipe_1))
    visit shared_recipes_path

    click_link @recipe_2.name

    expect(page).to have_content(@recipe_2.name)
    expect(current_path).to eq(shared_recipe_path(@recipe_2))
  end

  scenario 'User can see show pages of shared recipes' do
    visit shared_recipe_path(@recipe_1)

    expect(page).to_not have_content("You don't have permission")
  end

  scenario 'Subscribed recipes do not appear in shared recipes' do
    pending('Recipes are as yet unsubscribable')
    visit shared_recipe_path(@recipe_1)

    click_button 'Subscribe'

    visit shared_recipes_path

    expect(page).to_not have_content(@recipe_1.name)
  end

end
