class Admin::UsersController < ApplicationController
  before_action :verify_admin

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "#{user.username} deleted!"
    redirect_to admin_users_path
  end
end
