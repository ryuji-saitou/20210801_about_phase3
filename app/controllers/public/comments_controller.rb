class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    @comment.save
    @post.create_notification_comment!(current_user, @comment.id)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(post_id: params[:post_id], id: params[:id]).destroy
    redirect_to post_path(@post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
