class Public::ReportsController < ApplicationController
  def post_report_create
    @post = Post.find(params[:post_id])
    @report = Report.new
    @report.user_id = current_user.id
    @report.post_id = @post.id
    @report.save!
    redirect_to request.referer
  end

  def post_report_destroy
    @post = Post.find(params[:post_id])
    @report = Report.find_by(post_id: @post.id, user_id: current_user)
    @report.destroy
    redirect_to request.referer
  end

  def comment_report_create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @report = Report.new
    @report.user_id = current_user.id
    @report.post_id = @post.id
    @report.comment_id = @comment.id
    @report.save
    redirect_to request.referer
  end

  def comment_report_destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @report = Report.find_by(post_id: @post.id, comment_id: @comment.id, user_id: current_user)
    @report.destroy!
    redirect_to request.referer
  end
end
