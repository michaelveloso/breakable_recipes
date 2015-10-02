class IngredientsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @ingredients = Ingredient.all
  end

  def new
    check_permission
    @ingredient = Ingredient.new
  end

  def create
    check_permission
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient added!"
      redirect_to ingredients_path
    else
      flash[:errors] = @ingredient.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    check_permission
    @ingredient = this_ingredient
  end

  def update
    check_permission
    @ingredient = this_ingredient
    if @ingredient.update_attributes(ingredient_params)
      flash[:success] = "Ingredient updated!"
      redirect_to ingredients_path
    else
      flash[:errors] = @ingredient.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    check_permission
    @ingredient = this_ingredient
    @ingredient.destroy
    flash[:success] = "Ingredient removed!"
    redirect_to ingredients_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :subtype)
  end

  def check_permission
    if not current_user.role == 'admin' || current_user.role == 'moderator'
      flash[:errors] = 'You don\'t have permission to do that!'
      redirect_to ingredients_path
    end
  end

  def this_ingredient
    Ingredient.find(params[:id])
  end
end
