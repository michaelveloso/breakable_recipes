require 'rails_helper'

feature 'user can unsubscribe from a shared recipe', %{
  As a user,
  I want to subscribe to a shared recipe
  So that I can collect more recipes

  Acceptance criteria:

  [√] User can unsubscribe from a shared recipe from its show page
  [√] User can unsubscribe from a shared recipe from recipe index
  [√] User is notified of successful unsubscription
  [√] Unsubscribed recipes appear in shared recipes
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe_complete, shared: true)
    Subscription.create(user: @user, recipe: @recipe)
    sign_in(@user)
  end

  scenario 'User can unsubscribe from a shared recipe from its show page' do
    visit shared_recipe_path(@recipe)

    click_button 'Unsubscribe'

    expect(page).to have_content(
      "You have successfully unsubscribed from this recipe")
    expect(current_path).to eq(recipes_path)
  end

  scenario 'User can unsubscribe from a shared recipe from index' do
    visit recipes_path

    click_button 'Unsubscribe'

    expect(page).to_not have_content(@recipe.name)
  end

  scenario 'Unsubscribed recipes reappear in shared recipes' do
    visit shared_recipe_path(@recipe)

    click_button 'Unsubscribe'

    visit shared_recipes_path

    expect(page).to have_content(@recipe.name)
  end
end
