class Api::PostsController < ApplicationController
  # !ЭТО НЕ ХОРОШО !ЭТО СДЕЛАЛ Я !ПРОСТО СКИПНУЛ АУТЕНТИФИКАЦИЮ НА ЗАПРОС, ЧТОБЫ ВРЕМЯ НЕ ТЕРЯТЬ, НО ТАК ДЕЛАТЬ ПЛОХО
  skip_before_action :verify_authenticity_token

  # Тут я сделал вывод в формате json сущность Post
  # Сделал создание постов с комментариями
  # Запермитил атрибуты - все комментарии по действиям ниже

  def index
    # 1) Прочитать про includes - что это такое и для чего нужно https://engineering.gusto.com/a-visual-guide-to-using-includes-in-rails/
    # 2) Прочить про проблему N+1 https://semaphoreci.com/blog/2017/08/09/faster-rails-eliminating-n-plus-one-queries.html
    # 3) Прочитать про as_json https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
    @post = Post.includes([:comments]).all

    render json: @post.as_json(include: :comments)
  end

  def create
    # 1) Так выглядит создание поста с комментариями в апи (автоматом current_user, не проставляется, но ничего страшного)
    @post = Post.new(post_params)

    if @post.save
      render json: @post.as_json(include: :comments)
    else
      render json: { success: false, errors: @post.errors.as_json }, status: :unprocessable_entity
    end
  end

  private def post_params
    # 1) Я думаю с permit на базовом уровне ты разобрался, но тут я добавил permit для аттрибутов вложенной модели https://stackoverflow.com/questions/15919761/nested-attributes-unpermitted-parameters
    params.require(:post).permit(:title, :body, :user_id, comments_attributes:[:id, :username, :body, :post_id, :user_id])
  end
end