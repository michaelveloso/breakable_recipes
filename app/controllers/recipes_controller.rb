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
    @recipe = Recipe.new
    2.times { @recipe.categories.build }
    10.times { @recipe.recipe_steps.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      recipe_category_ids.each do |category_id|
        RecipeCategory.create(recipe: @recipe, category_id: category_id[1][:id])
      end
      recipe_steps.each do |order, body_hash|
        RecipeStep.create(recipe: @recipe, order: (order.to_i + 1), body: body_hash[:body])
      end
      flash[:success] = "Recipe added!"
      redirect_to recipe_path(@recipe)
    else
      flash[:errors] = @recipe.errors.full_messages.join(', ')
      @category_options = category_options
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

  def category_options
    options = [[nil]]
    Category.all.each do |category|
      options << [category.name, category.id]
    end
    options
  end

  def recipe_category_ids
    params[:recipe][:categories_attributes].select { |id| id.length > 0 }
  end

  def recipe_steps
    params[:recipe][:recipe_steps_attributes].select { |body| body.length > 0}
  end
end
