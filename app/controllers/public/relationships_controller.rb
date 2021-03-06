class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!, except: [:followings, :followers]

  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
    # ▲下記を簡素化したもの / "follow"はModel(user.rb)にて定義
    # @relationship = Relationship.new
    # @user = User.find(params[:user_id])
    # @relationship.follower_id = current_user.id
    # @relationship.followed_id = @user.id
    # @relationship.save
    # redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    # ▲下記を簡素化したもの / "unfollow"はModel(user.rb)にて定義
    # @user = User.find(params[:user_id])
    # @relationship = Relationship.find_by(followed_id: @user.id, follower_id: current_user.id)
    # @relationship.destroy
    # redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    # "followings"はModel(user.rb)にて定義
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    # "followers"はModel(user.rb)にて定義
  end
end
