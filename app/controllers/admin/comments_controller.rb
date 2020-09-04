class Admin::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(comment_params)

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