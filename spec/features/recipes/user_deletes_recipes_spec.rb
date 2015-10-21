require 'rails_helper'

feature 'user can delete recipes', %{
  As an authenticated user,
  I want to by able to delete my own recipes
  So that I can get rid of ones I don't like anymore

  Acceptance criteria:

  [√] I can delete my recipes from my index page
  [√] I can delete my recipes from their show pages
  [√] User lands on recipe index after deletion
  [√] I am given confirmation when a recipe is deleted
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe_complete, user: @user)
    sign_in(@user)
  end

  scenario 'user can delete recipes from index' do
    visit recipes_path
save_and_open_page
    click_button("Delete")

    visit recipes_path

    expect(page).to_not have_content(@recipe.name)
  end

  scenario 'user can delete recipes from show' do
    visit recipe_path(@recipe)

    click_button("Delete this recipe")

    visit recipes_path

    expect(page).to_not have_content(@recipe.name)
  end

  scenario 'user lands on recipe index after deletion' do
    visit recipe_path(@recipe)

    click_button("Delete this recipe")

    expect(current_path).to eq(recipes_path)
  end

  scenario 'user is notified of successful deletion' do
    visit recipe_path(@recipe)

    click_button("Delete this recipe")

    expect(page).to have_content("#{@recipe.name} deleted!")
  end
end
