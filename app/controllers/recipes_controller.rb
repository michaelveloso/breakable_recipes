class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user: current_user).order(:name)
  end

  def show
    @recipe = Recipe.find(params[:id])
    check_owner(@recipe)
    @ingredients = @recipe.ingredient_lists
    @steps = @recipe.recipe_steps.order(:order)
  end

  private

  def check_owner(recipe)
    if not current_user == recipe.user
      flash[:errors] = "You don't have permission to see this recipe"
      redirect_to root_path
    end
  end
end
