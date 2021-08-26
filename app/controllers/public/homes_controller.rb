class Public::HomesController < ApplicationController
  def home
    if user_signed_in?
      # 全ての投稿 / tab = new
      if params[:tab] == 'new'
        @all_posts = Post.order(created_at: "desc").page(params[:page]).per(5)
      # フォロー中ユーザーの投稿 / tab = timeline
      elsif params[:tab] == 'timeline' || !params[:tab].present?
        user = User.find(current_user.id)
        @users = user.followings
        # 下記where後 "user_id: [@users, current_user]" にすることで自分の投稿もタイムラインに表示する
        @follow_posts = Post.where(user_id: [@users, current_user]).order("created_at DESC").page(params[:page]).per(5)
      end

    else
      @all_posts = Post.order(created_at: "desc").page(params[:page]).per(5)
    end
  end

  def about
  end
end
