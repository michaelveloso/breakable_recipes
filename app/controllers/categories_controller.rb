class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_moderator

  def index
    @categories = Category.order(:name)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category added!"
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages.join(', ')
      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
