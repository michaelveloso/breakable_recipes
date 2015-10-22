require 'rails_helper'

feature 'user can see index of shared recipes', %{
  As a user,
  I want to see a list of all shared recipes
  So that I can find new recipes

  Acceptance criteria:

  [√] User sees shared recipes at /shared/recipes
  [√] User can see show pages of shared recipes
  [√] User can navigate back to shared recipe index
  [√] User can navigate back to their recipes
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe_complete, shared: true)
    @recipe_2 = FactoryGirl.create(:recipe_complete, shared: true)
    sign_in(user)
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

  scenario 'User can navigate back to shared recipe index' do
    visit shared_recipe_path(@recipe_1)

    click_button("Back to shared recipes")

    expect(current_path).to eq(shared_recipes_path)
  end

  scenario 'User can navigate back to their recipe index' do
    visit shared_recipe_path(@recipe_1)

    click_button("Back to my recipes")

    expect(current_path).to eq(recipes_path)
  end

end
