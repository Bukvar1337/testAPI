class Admin::PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @post = Post.where(["title LIKE ?", "%#{params[:search]}%"]).page(params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
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
    @post = current_user.posts.build(post_params)

    if(@post.save)
      redirect_to @post
    else
      render 'new'
    end
  end

  private def post_params
    params.require(:post).permit(:title, :body)
  end
end