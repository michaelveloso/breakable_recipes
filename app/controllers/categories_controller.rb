class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permission

  def index
    @categories = Category.order(:name)
  end
end
