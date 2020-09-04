class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.includes([:posts]).includes([:comments]).where(["email LIKE ?", "%#{params[:search]}%"])
    render json: @user.as_json(include:([:posts]))
  end

  def update
    @user = User.find(params[:id])

    if(@user.update(user_params))
      render json: @user.as_json(include: :posts)
    else
      render json: { success: false, errors: @user.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    redirect_to api_users_path
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json
    else
      render json: { success: false, errors: @user.errors.as_json }, status: :unprocessable_entity
    end
  end

  private def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :admin)
  end

end
