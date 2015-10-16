class Admin::UsersController < ApplicationController
  def index
    verify_admin
    @users = User.all
  end
end
