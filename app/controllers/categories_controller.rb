class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_moderator

  def index
    @categories = categories
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category added!"
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages.join(', ')
      @categories = categories
      render :index
    end
  end

  def edit
    @category = this_category
  end

  def update
    @category = this_category
    if @category.update_attributes(category_params)
      flash[:success] = "Category edited!"
      redirect_to categories_path
    else
      flash[:errors] = @category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    if this_category.destroy
      flash[:success] = "Category deleted!"
    else
      flash[:errors] = this_category.errors.full_messages.join(', ')
    end
    @categories = categories
    redirect_to categories_path
  end

  private

  def categories
    Category.order(:name)
  end

  def this_category
    Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
