require 'rails_helper'

feature 'user sees recipe index', %{
  As an authenticated user
  I want see a list of my recipes
  So I know what's available

  Acceptance criteria:

  [√] - User sees their recipes at recipes path
  [√] - Recipes are in alphabetical order
  [] - Recipes are links to their show pages
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe, user: @user)
    sign_in(@user)
  end

  scenario 'user sees their recipes on index' do
    visit recipes_path

    expect(page).to have_content(@recipe.name)
  end

  scenario 'user does not see others\' recipes on index' do
    other_recipe = FactoryGirl.create(:recipe)
    visit recipes_path

    expect(page).to_not have_content(other_recipe.name)
  end

  scenario 'recipes are in alphabetical order' do
    FactoryGirl.create(:recipe, name: "BBB", user: @user)
    FactoryGirl.create(:recipe, name: "AAA", user: @user)
    visit recipes_path

    expect("AAA").to appear_before("BBB")
  end

  scenario 'recipes are links to their show pages' do
    save_and_open_page
    click_link(@recipe.name)

    expect(current_path).to eq(recipe_path(@recipe))
  end

end
