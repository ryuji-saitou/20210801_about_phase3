class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :user_name,
      :user_name_id,
      :profile_image,
      :profile_introduction,
      :profile_sns_link
    )
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
