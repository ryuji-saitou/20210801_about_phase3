class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
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
end
