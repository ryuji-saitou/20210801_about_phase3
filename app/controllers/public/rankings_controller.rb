class Public::RankingsController < ApplicationController
  def index
    @date = Time.now
    @ranking_posts = Post.find(
        Favorite.joins(:post).group(:post_id)
        .where("posts.created_at": (@date.beginning_of_month)..(@date.end_of_month))
        .order('count(post_id) desc')
        .pluck(:post_id)
      )
  end

  def ranking_search
    # @date = params[:year_month]
    @date = Date.new(params["year_month(1i)"].to_i,params["year_month(2i)"].to_i,params["year_month(3i)"].to_i) # (3i)は日付指定のためなくても動く
    @ranking_posts = Post.find(
        Favorite.joins(:post).group(:post_id)
        .where("posts.created_at": (@date.beginning_of_month)..(@date.end_of_month))
        .order('count(post_id) desc')
        .pluck(:post_id)
      )
    render :index
  end
end
