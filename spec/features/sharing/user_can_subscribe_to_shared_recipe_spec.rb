require 'rails_helper'

feature 'user can subscribe to a shared recipe', %{
  As a user,
  I want to subscribe to a shared recipe
  So that I can collect more recipes

  Acceptance criteria:

  [] User can subscribe to a shared recipe from its show page
  [] User is notified on successful subscription
  [] Subscribed recipes appear in recipes_path
  [] Subscribed recipes do not appear in shared recipes
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    @recipe_1 = FactoryGirl.create(:recipe_complete, shared: true)
    @recipe_2 = FactoryGirl.create(:recipe_complete, shared: true)
    sign_in(user)
  end

  scenario 'User can subscribe to a shared recipe from its show page' do
    visit shared_recipe_path(@recipe_1)

    click_button 'Subscribe'

    expect(page).to have_content(
      "You have successfully subscribed to this recipe!")
  end

  scenario 'Subscribed recipes appear in recipes_path' do
    visit shared_recipe_path(@recipe_1)

    click_button 'Subscribe'

    visit recipes_path

    expect(page).to have_content(@recipe_1.name)
    expect(page).to_not have_content(@recipe_2.name)

    click_link @recipe_1.name
    expect(current_path).to eq(shared_recipe_path(@recipe_1))
  end

  scenario 'Subscribed recipes do not appear in shared recipes' do
    pending('Recipes are as yet unsubscribable')
    visit shared_recipe_path(@recipe_1)

    click_button 'Subscribe'

    visit shared_recipes_path

    expect(page).to_not have_content(@recipe_1.name)
    expect(page).to have_content(@recipe_2.name)
  end
end
