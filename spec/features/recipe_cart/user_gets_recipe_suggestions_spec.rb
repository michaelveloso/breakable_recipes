require 'rails_helper'

feature 'user gets suggestions from shopping list', %{
  As a user,
  I want to get suggestions for more recipes
  So that I can don't waste ingredients

  Acceptance criteria:
  [] User can choose ingredients from shopping list page
  [] User can click button to get suggested recipes
  [] User sees list of suggested recipes
  [] Suggested recipes do not include recipes already in cart
  [] If no suggestions, user is informed
  [] Page includes links to recipe index and shopping cart
} do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @recipe = FactoryGirl.create(:recipe_complete, user: @user)
    sign_in(@user)
  end

  scenario 'user can choose ingredients from shopping list page' do
    pending
    expect(true).to eq(false)
  end

  scenario 'user clicks button to get suggested recipes' do
    pending
    expect(true).to eq(false)
  end

  scenario 'user sees list of suggested recipes' do
    pending
    expect(true).to eq(false)
  end

  scenario 'suggested recipes do not include recipes already in cart' do
    pending
    expect(true).to eq(false)
  end

  scenario 'If no suggestions, user is informed' do
    pending
    expect(true).to eq(false)

  end

  scenario 'Page includes links to recipe index and shopping cart' do
    pending
    expect(true).to eq(false)
  end
end
