class PostsController < ApplicationController
  load_and_authorize_resource
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @post = Post.order(:title).page(params[:page])
  end

  def new
    @post = current_user.posts.new
    @post.comments.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    render json: @post, include: :comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if(@post.update(post_params))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_path
  end

  def create
    # render plain: params[:post].inspect
    @post = current_user.posts.new(post_params)
    @post.comments.each {|comment| comment.user_id = current_user.id}

    if(@post.save)
      redirect_to @post
    else
      render 'new'
    end
  end

  private def post_params
    params.require(:post).permit([:title, :body], comments_attributes:[:body])
  end
end