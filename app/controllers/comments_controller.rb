class CommentsController < ApplicationController

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    @comment = Comment.all
  end

  def create
    # First get the parent post:
    @post = Post.find(params[:post_id])

    # Then build the associated model through the parent (this will give it the correct post_id)
    @comment = @post.comments.build(comment_params)

    # Assign the user directly
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private def comment_params
    params.require(:comment).permit(:body)
  end

end

#def create
#@comment = Comment.new(comment_params)
#@post = Post.find(params[:post_id])
#@comment.user_id = current_user.id
# @comment.post_id=@post.id
#@comment.save
# redirect_to post_path(@post)
#end