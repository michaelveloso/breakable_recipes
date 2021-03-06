class Admin::UsersController < ApplicationController
  before_action :verify_admin

  def index
    @users = User.all
  end

  def destroy
    user = this_user
    user.destroy
    flash[:notice] = "#{user.username} deleted!"
    redirect_to admin_users_path
  end

  def show
    @user = this_user
  end

  def update
    @user = this_user
    if @user.update_attributes(role_params)
      flash[:success] = @user.current_role_string
    else
      flash[:errors] = @user.errors.full_messages.join(', ')
    end
    redirect_to admin_user_path(@user)
  end

  private

  def this_user
    User.find(params[:id])
  end

  def role_params
    { role: params[:role] }
  end
end
