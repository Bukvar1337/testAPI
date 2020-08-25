class PagesController < ApplicationController
  def about
    @post = Post.all
    render json: @post
  end
end

