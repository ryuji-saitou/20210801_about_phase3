class Public::SearchesController < ApplicationController
  def search
  end

  def search_result
    @user = User.find(1)
    render :search
  end
end
