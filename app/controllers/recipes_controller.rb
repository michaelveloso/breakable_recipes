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
    @category_options = category_options
    @ingredient_options = ingredient_options
    @recipe = Recipe.new
    @recipe.categories.build
    @recipe.ingredient_lists.build
    @recipe.recipe_steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      add_recipe_categories
      add_ingredient_lists
      add_recipe_steps
      flash[:success] = "Recipe added!"
      redirect_to recipe_path(@recipe)
    else
      flash[:errors] = @recipe.errors.full_messages.join(', ')
      redirect_to new_recipe_path
    end
  end

  def edit
    check_user
    @category_options = category_options
    @ingredient_options = ingredient_options
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      add_recipe_categories
      add_ingredient_lists
      add_recipe_steps
      flash[:success] = "Recipe edited!"
      redirect_to recipe_path(@recipe)
    else
      flash[:errors] = @recipe.errors.full_messages.join(', ')
      redirect_to edit_recipe_path(@recipe)
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "#{@recipe.name} deleted!"
    redirect_to recipes_path
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

  def category_options
    options = [['(Choose a category)', nil]]
    Category.order(:name).each do |category|
      options << [category.name, category.id]
    end
    options
  end

  def ingredient_options
    options = [['(Choose an ingredient)', nil]]
    Ingredient.order(:name, :subtype).each do |ingredient|
      options << [ingredient.for_dropdown, ingredient.id]
    end
    options
  end

  def add_recipe_categories
    RecipeCategory.destroy_all(recipe: @recipe)
    if recipe_category_ids
      recipe_category_ids.each do |_key, category_id|
        RecipeCategory.create(
          recipe: @recipe,
          category_id: category_id[:id])
      end
    end
  end

  def add_ingredient_lists
    IngredientList.destroy_all(recipe: @recipe)
    if ingredient_lists
      ingredient_lists.each do |_key, info|
        IngredientList.create(
          recipe: @recipe,
          ingredient_id: info[:id],
          amount: info[:amount],
          preparation: info[:preparation],
          step: info[:step]
        )
      end
    end
  end

  def add_recipe_steps
    RecipeStep.destroy_all(recipe: @recipe)
    if recipe_steps
      recipe_steps.each do |order, body_hash|
        RecipeStep.create(
          recipe: @recipe,
          order: (order.to_i + 1),
          body: body_hash[:body])
      end
    end
  end

  def recipe_category_ids
    if params[:recipe][:categories_attributes]
      params[:recipe][:categories_attributes].select { |id| id.length > 0 }
    end
  end

  def recipe_steps
    if params[:recipe][:recipe_steps_attributes]
      params[:recipe][:recipe_steps_attributes].
        select { |body| body.length > 0 }
    end
  end

  def ingredient_lists
    if params[:recipe][:ingredient_lists_attributes]
      params[:recipe][:ingredient_lists_attributes].
        select { |id| id.length > 0 }
    end
  end

  def check_user
    unless current_user == Recipe.find(params[:id]).user
      flash[:errors] = "You don't have permission to do that!"
      redirect_to root_path
    end
  end
end
