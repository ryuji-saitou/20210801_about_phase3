class Public::RankingsController < ApplicationController
  def index
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def result
    @year_month = params["search"]["year_month"]
    # @budget_min = params["search"]["budget_min"]
    # @budget_max = params["search"]["budget_max"]
    @posts = Post.all
    @posts = @post.where(DATE_FORMAT(created_at, "%Y%m" = @year_month)
    p @year_month
    p @budget_min
    p @budget_max
  end

  private
  def
end
