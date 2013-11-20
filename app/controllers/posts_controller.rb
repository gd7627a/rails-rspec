class PostsController < ApplicationController
  def index
    p "Hello"
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

end