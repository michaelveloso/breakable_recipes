require 'rails_helper'

feature 'user can edit recipes', %{
  As an authenticated user,
  I want to by edit my recipes
  So that I keep them up-to-date

  Acceptance criteria:

  [√] I can edit my recipes from my index page
  [√] I can edit my recipes from their show pages
  [√] Only a recipe's owner can edit a recipe
  [√] Edit page has attributes pre-filled
  [] Recipe is updated correctly
  [√] I am shown errors if name is not filled out
  [√] I am given confirmation when a recipe is edited
  [√] I am taken to recipe show page upon successful editing
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

  context 'edit page has its attributes pre-filled' do

    before(:each) do
      visit edit_recipe_path(@recipe)
    end

    scenario 'recipe static attributes are pre-filled' do
      expect(page).to have_content(@recipe.name)
      expect(find('#recipe_complexity').value).to eq(@recipe.complexity.to_s)
      expect(find('#recipe_cooking_time').value).to have_content(@recipe.cooking_time)
      expect(find('#num-served-min-input').value).to eq(@recipe.num_served_min.to_s)
      expect(find('#num-served-max-input').value).to eq(@recipe.num_served_max.to_s)
    end

    scenario 'recipe categories are pre-filled' do
      @recipe.categories.each_with_index do |category, index|
        expect(find(cat_id_str(index)).value).to eq(category.id.to_s)
      end
    end

    scenario 'recipe ingredients are pre-filled' do
      @recipe.ingredient_lists.each_with_index do |il, index|
        expect(find(ingr_select_id_str(index)).value).to eq(il.ingredient.id.to_s)
        expect(find(ingr_amount_str_by_id(index)).value).to eq(il.amount)
        expect(find(ingr_prep_str_by_id(index)).value).to eq(il.preparation)
      end
    end

    scenario 'recipe steps are pre-filled' do
      @recipe.recipe_steps.each_with_index do |recipe_step, index|
        expect(find(step_body_str_by_id(index)).value).to eq(recipe_step.body)
      end
    end
  end

  context 'recipe is updated correctly' do
    before(:each) do
      visit edit_recipe_path(@recipe)
    end

    scenario 'simple attributes are updated' do
      fill_in 'Recipe Name', with: "Updated Name"
      select '2', from: 'recipe_complexity'
      fill_in 'recipe_cooking_time', with: '53'
      fill_in 'num-served-min-input', with: '5'
      fill_in 'num-served-max-input', with: '8'

      click_button 'Update this Recipe!'

      expect(page).to have_content("Updated Name")
      expect(page).to have_content("Complexity: 2")
      expect(page).to have_content("Cooking time: 53 min")
      expect(page).to have_content("Serves 5-8")
    end

    scenario 'categories are updated' do
      new_category = FactoryGirl.create(:category)
      visit edit_recipe_path(@recipe)

      select new_category.name, from: 'recipe_categories_attributes_0_id'
      click_button 'Update this Recipe!'

      expect(page).to have_content(new_category.name)
    end

    scenario 'ingredients are updated' do
      new_ingredient = FactoryGirl.create(:ingredient)
      visit edit_recipe_path(@recipe)

      select new_ingredient.name, from: 'recipe_ingredient_lists_attributes_0_id'
      fill_in (ingr_amount_str(0)), with: 'New Amount'
      fill_in (ingr_prep_str(0)), with: 'New Preparation'
      click_button 'Update this Recipe!'

      expect(page).to have_content("New Amount #{new_ingredient.to_s}, New Preparation")
    end

    scenario 'recipe steps are updated' do
      visit edit_recipe_path(@recipe)

      fill_in (step_body_str(0)), with: "New instructions"
      click_button 'Update this Recipe!'

      expect(page).to have_content("New instructions")
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

def cat_id_str(index)
  "select#recipe_categories_attributes_#{index}_id"
end

def ingr_select_id_str(index)
  "select#recipe_ingredient_lists_attributes_#{index}_id"
end

def ingr_amount_str_by_id(index)
  "#recipe_ingredient_lists_attributes_#{index}_amount"
end

def step_body_str_by_id(index)
  "#recipe_recipe_steps_attributes_#{index}_body"
end

def ingr_prep_str_by_id(index)
  "#recipe_ingredient_lists_attributes_#{index}_preparation"
end

def ingr_amount_str(index)
  "recipe_ingredient_lists_attributes_#{index}_amount"
end

def ingr_prep_str(index)
  "recipe_ingredient_lists_attributes_#{index}_preparation"
end

def step_body_str(index)
  "recipe_recipe_steps_attributes_#{index}_body"
end
