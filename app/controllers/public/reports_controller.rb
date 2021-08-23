class Public::ReportsController < ApplicationController
  def post_report_create
    @post = Post.find(params[:post_id])
    @report = Report.new
    @report.user_id = current_user.id
    @report.post_id = @post.id
    @report.save
  end

  def post_report_destroy
    @post = Post.find(params[:post_id])
    # comment_idが空のものを拾って削除したい
    @report = Report.find_by(post_id: @post.id, comment_id: nil, user_id: current_user)
    @report.destroy
  end

  def comment_report_create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @report = Report.new
    @report.user_id = current_user.id
    @report.post_id = @post.id
    @report.comment_id = @comment.id
    @report.save
  end

  def comment_report_destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @report = Report.find_by(post_id: @post.id, comment_id: @comment.id, user_id: current_user)
    @report.destroy
  end
end
