class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @recipes = Recipe.where(user: current_user).order(:name)
  end

  def show
    @recipe = Recipe.find(params[:id])
    check_owner(@recipe)
    @ingredients = @recipe.ingredient_lists
    @steps = @recipe.recipe_steps.order(:order)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe added!"
      redirect_to recipe_path(@recipe)
    else
      flash[:errors] = @recipe.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :complexity,
      :cooking_time,
      :num_served_min,
      :num_served_max).merge(user: current_user)
  end

  def check_owner(recipe)
    if not current_user == recipe.user
      flash[:errors] = "You don't have permission to see this recipe"
      redirect_to root_path
    end
  end
end
