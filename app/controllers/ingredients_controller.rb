class IngredientsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :verify_moderator, except: [:index]

  def index
    @ingredients = Ingredient.order(:name, :subtype)
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient added!"
      redirect_to ingredients_path
    else
      flash[:errors] = @ingredient.errors.full_messages.join(', ')
      @ingredients = Ingredient.order(:name, :subtype)
      render :index
    end
  end

  def edit
    @ingredient = this_ingredient
  end

  def update
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
    @ingredient = this_ingredient
    @ingredient.destroy
    flash[:success] = "Ingredient removed!"
    redirect_to ingredients_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :subtype)
  end

  def this_ingredient
    Ingredient.find(params[:id])
  end
end
