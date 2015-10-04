class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    confirm_user
    @user = User.find(params[:id])
  end
end
