class IngredientsController < ApplicationController
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

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :subtype)
  end

  def check_permission
    if current_user.present?
      if not current_user.role == 'admin' || current_user.role == 'moderator'
        flash[:errors] = 'You don\'t have permission to do that!'
        redirect_to root_path
      end
    else
      flash[:errors] = 'You\'re not signed in'
      redirect_to root_path
    end
  end
end
