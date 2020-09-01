class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  # Тут для вьюх все норм тоже, но замечание в update

  def index
    @user = User.all
  end

  def update
    @user = User.find(params[:id])

    # Вот это не очень понял, если честно
    # У тебя при каждом вызове update будет меняться параметр admin true -> false false -> true
    # обычно метод update используется для изменения всех параметорв сущности
    # я бы сделал это отдельным методом -> пример ниже
    # а в этом методе оставил бы обычный апдейт как у posts
    if @user.admin == true
      @user.admin = false
    else
      @user.admin = true
    end
    @user.save
    redirect_to users_path
  end

  # Отдельно так
  # ____________
  # в routes.rb
  # resources :users do
  #   member do
  #     put :reset_admin
  #   end
  # end
  # ____________
  # во вьюхе запрос отправлял бы на reset_admin_user_path
  def reset_admin
    if @user.admin == true
      @user.admin = false
    else
      @user.admin = true
    end
    @user.save
    redirect_to users_path
  end
end
