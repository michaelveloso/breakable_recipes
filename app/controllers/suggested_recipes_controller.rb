class SuggestedRecipesController < ApplicationController
  def show
    ids = get_ingredient_ids
    @recipes = RecipeSuggestor.get_recipes(ids)
    current_user.cart.recipes.each do |carted_recipe|
      @recipes.delete(carted_recipe)
    end
  end

  private

  def get_ingredient_ids
    ids = []
    params[:id].each do |_key, value|
      ids << value
    end
    ids
  end
end
