class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
      @comment.destroy
    else
      redirect_to post_path(@post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    redirect_to root_path unless @post.user == current_user
  end
end