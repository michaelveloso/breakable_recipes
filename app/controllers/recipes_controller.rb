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
      @ingredient_options = ingredient_options
      @category_options = category_options
      @recipe.categories.build
      @recipe.ingredient_lists.build
      @recipe.recipe_steps.build
      render :new
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
    recipe_category_ids.each do |_key, category_id|
      RecipeCategory.create(
        recipe: @recipe,
        category_id: category_id[:id])
    end
  end

  def add_ingredient_lists
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

  def add_recipe_steps
    recipe_steps.each do |order, body_hash|
      RecipeStep.create(
        recipe: @recipe,
        order: (order.to_i + 1),
        body: body_hash[:body])
    end
  end

  def recipe_category_ids
    params[:recipe][:categories_attributes].select { |id| id.length > 0 }
  end

  def recipe_steps
    params[:recipe][:recipe_steps_attributes].select { |body| body.length > 0 }
  end

  def ingredient_lists
    params[:recipe][:ingredient_lists_attributes].select { |id| id.length > 0 }
  end
end
