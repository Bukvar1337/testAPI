class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  #load_and_authorize_resource

  def index
    @user = User.all
    #render json: @user
  end

  def update
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
