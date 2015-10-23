class Shared::RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.where(shared: true).where.not(user: current_user).order(:name)
    current_user.subscribed_recipes.each do |recipe|
      @recipes.delete(recipe)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredient_lists
    @steps = @recipe.recipe_steps.order(:order)
  end
end
