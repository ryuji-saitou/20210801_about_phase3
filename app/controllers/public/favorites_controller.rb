class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.favorites.new(post_id: @post.id).save
    @post.create_notification_favorite!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.favorites.find_by(post_id: @post.id).destroy
  end
end