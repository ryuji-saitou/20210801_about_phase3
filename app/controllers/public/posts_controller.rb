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
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path
    else
      render :confirm
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:action, :post_image, :time_required, :budget)
  end
end
