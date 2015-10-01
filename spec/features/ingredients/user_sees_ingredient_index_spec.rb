require 'rails_helper'

feature 'user sees ingredient index', %{
  As an unauthenticated user
  I want see a list of ingredients
  So I know what's available

  Acceptance criteria:

  [] - User sees ingredients at /ingredients
} do

  scenario 'user can see ingredient list' do
    ingredient = FactoryGirl.create(:ingredient)
    visit ingredients_path

    expect(page).to have_content(ingredient.name)
  end
end
