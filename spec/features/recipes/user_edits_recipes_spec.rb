require 'rails_helper'

feature 'user can edit recipes', %{
  As an authenticated user,
  I want to by edit my recipes
  So that I keep them up-to-date

  Acceptance criteria:

  [] I can edit my recipes from my index page
  [] I can edit my recipes from their show pages
  [] Only a recipe's owner can edit a recipe
  [] Edit page has attributes pre-filled
  [] I am shown errors if name is not filled out
  [] I am given confirmation when a recipe is edited
  [] I am taken to recipe show page upon successful editing
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe_complete, user: @user)
    sign_in(@user)
  end

  scenario 'user can edit recipes from index' do
    visit recipes_path

    click_button("Edit")

    expect(current_path).to eq(edit_recipe_path(@recipe))
  end

  scenario 'user can edit recipes from show' do
    visit recipe_path(@recipe)

    click_button("Edit this recipe")

    expect(current_path).to eq(edit_recipe_path(@recipe))
  end

  scenario 'recipe can only be edited by its owner' do
    bad_user = FactoryGirl.create(:user)
    click_link 'Sign Out'

    sign_in(bad_user)

    visit edit_recipe_path(@recipe)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You don't have permission to do that")
  end

  scenario 'edit page has its attributes pre-filled' do
    visit edit_recipe_path(@recipe)

    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.cooking_time)
    @recipe.categories.each do |category|
      expect(page).to have_content(category.name)
    end
    @recipe.ingredients.each do |ingredient|
      expect(page).to have_content(ingredient.to_s)
    end
    @recipe.ingredient_lists.each do |ingredient_list|
      expect(page).to have_content(ingredient_list.amount)
      expect(page).to have_content(ingredient_list.preparation)
      expect(page).to have_content(ingredient_list.step)
    end
    @recipe.recipe_steps.each do |recipe_step|
      expect(page).to have_content(recipe_step.body)
    end
  end

  scenario 'I am shown errors if name is not filled out' do
    visit edit_recipe_path(@recipe)

    fill_in 'Recipe Name', with: ""
    click_button 'Update this Recipe!'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'I am given confirmation when a recipe is edited' do
    visit edit_recipe_path(@recipe)

    fill_in 'Recipe Name', with: "New Name for Recipe"
    click_button 'Update this Recipe!'

    expect(page).to have_content("Recipe edited!")
  end

  scenario 'I am taken to recipe show page upon successful editing' do
    visit edit_recipe_path(@recipe)

    fill_in 'Recipe Name', with: "New Name for Recipe"
    click_button 'Update this Recipe!'

    expect(current_path).to eq(recipe_path(@recipe))

  end
end
