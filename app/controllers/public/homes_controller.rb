class Public::HomesController < ApplicationController
  def home
    if user_signed_in?
      # asc:昇順 / desc:降順
      # 全ての投稿
      @all_posts = Post.order(created_at: "desc").page(params[:page]).per(5)
      # フォロー中ユーザーの投稿
      user = User.find(current_user.id)
      @users = user.followings
      @follow_posts = @all_posts.where(user_id: @users).order("created_at DESC").page(params[:page]).per(5)
    else
      @all_posts = Post.order(created_at: "desc").page(params[:page]).per(5)
    end
  end

  def about
  end
end
