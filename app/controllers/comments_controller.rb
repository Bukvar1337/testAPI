class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    redirect_to post_path(@post)
  end

  private def comment_params
    params.require(:comment).permit(:body)
  end

end
