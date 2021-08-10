class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
  end

  def back
    @post = Post.new(post_params)
    render :new
  end

  def create
    @post = Post.new(post_params)
  end

  def show
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:action, :post_image, :time_required, :budget)
  end
end
