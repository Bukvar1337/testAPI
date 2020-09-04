class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.all
  end

  def update

  end

  def reset_admin
    @user = User.find(params[:id])
    if @user.admin == true
      @user.admin = false
    else
      @user.admin = true
    end
    @user.save
    redirect_to users_path
  end
end
