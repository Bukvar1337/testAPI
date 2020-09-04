class Api::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @post = Post.includes([:comments]).where(["title LIKE ?", "%#{params[:search]}%"])
    render json: @post.as_json(include: :comments)
  end

  def update
    @post = Post.find(params[:id])

    if(@post.update(post_params))
      render json: @post.as_json(include: :comments)
    else
      render json: { success: false, errors: @post.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to api_posts_path
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