class RecipeCartsController < ApplicationController

  def show
  end

  def update
    current_user.cart.recipes << Recipe.find(params[:recipe_id])
    redirect_to recipe_cart_path
  end
end
