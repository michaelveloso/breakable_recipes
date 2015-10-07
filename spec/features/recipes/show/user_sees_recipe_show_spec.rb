require 'rails_helper'

feature 'user sees recipe details on show page', %{
  As an authenticated user
  I want see details of a recipe
  So I can cook using it

  Acceptance criteria:

  [√] All recipe attributes are visible
  [√] Recipe steps are in correct order
  [√] Recipe is only visible to owner
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  scenario 'user sees all recipe attributes' do
    recipe = FactoryGirl.create(:recipe_complete, user: @user)
    visit recipe_path(recipe)

    expect(page).to have_content(recipe.name)
    expect(page).to have_content(recipe.complexity_rating)
    expect(page).to have_content(recipe.cooking_time_min)
    expect(page).to have_content(recipe.num_served)
    recipe.categories.each do |category|
      expect(page).to have_content(category.name)
    end
    recipe.ingredient_lists.each do |ingredient_list|
      expect(page).to have_content(ingredient_list.to_s)
    end
    recipe.recipe_steps.each do |recipe_step|
      expect(page).to have_content(recipe_step.body)
    end
  end

  scenario 'recipe steps are in correct order' do
    recipe = FactoryGirl.create(:recipe, user: @user)
    RecipeStep.create(recipe: recipe, body: "Second", order: 2)
    RecipeStep.create(recipe: recipe, body: "First", order: 1)
    visit recipe_path(recipe)

    expect("First").to appear_before("Second")
  end

  scenario 'recipes are only visible to owner' do
    recipe = FactoryGirl.create(:recipe, user: @user)
    other_user = FactoryGirl.create(:user)
    click_link("Sign Out")
    sign_in(other_user)

    visit recipe_path(recipe)
    expect(page).to have_content("You don't have permission")
  end
end
