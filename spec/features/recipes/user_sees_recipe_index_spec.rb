require 'rails_helper'

feature 'user sees recipe index', %{
  As an authenticated user
  I want see a list of my recipes
  So I know what's available

  Acceptance criteria:

  [√] - Unregistered user sees invitation to sign up
  [√] - Registered user sees their recipes at recipes path
  [√] - Recipes are in alphabetical order
  [√] - Recipes are links to their show pages
  [√] - Recipe attributes are listed next to their recipe
} do

  scenario 'unregistered user sees invitation to sign up' do
    visit recipes_path

    expect(page).to have_content("Sign in or Sign up to add recipes!")
  end

  context 'registered user' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @recipe = FactoryGirl.create(:recipe_complete, user: @user)
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
      visit recipes_path
      click_link(@recipe.name)

      expect(current_path).to eq(recipe_path(@recipe))
    end

    scenario 'recipes show their simple attributes' do
      visit recipes_path

      expect(page).to have_content(@recipe.cooking_time_min)
      expect(page).to have_content(@recipe.complexity_rating)
      expect(page).to have_content(@recipe.num_served)
      @recipe.categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end
  end
end
