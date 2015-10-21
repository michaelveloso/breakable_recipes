class SuggestedRecipesController < ApplicationController
  def show
    ids = get_ingredient_ids
    if !ids.empty?
      @recipes = RecipeSuggestor.get_recipes(ids, current_user)
      current_user.cart.recipes.each do |carted_recipe|
        @recipes.delete(carted_recipe)
      end
    else
      flash[:errors] = "No ingredients tagged!"
      redirect_to shopping_list_path
    end
  end

  private

  def get_ingredient_ids
    ids = []
    if params[:id]
      params[:id].each do |_key, value|
        ids << value
      end
    end
    ids
  end
end
