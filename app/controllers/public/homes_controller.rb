class Public::HomesController < ApplicationController
  def home
    # asc:昇順 / desc:降順
    @posts = Post.order(created_at: "asc").page(params[:page]).per(5)
  end

  def about
  end
end
