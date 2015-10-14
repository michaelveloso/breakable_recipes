class RecipeCartsController < ApplicationController
  def show
  end

  def update
    current_user.cart.recipes << this_recipe
    redirect_to recipe_cart_path
  end

  def destroy
    if params[:recipe_id] == 'all'
      flash[:success] = 'All recipes cleared!'
      current_user.cart.recipes = []
    else
      flash[:success] = "#{this_recipe.name} removed from cart!"
      current_user.cart.recipes.delete(this_recipe)
    end
    redirect_to recipe_cart_path
  end

  private

  def this_recipe
    Recipe.find(params[:recipe_id])
  end
end
