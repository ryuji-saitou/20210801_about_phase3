class Public::SearchesController < ApplicationController
  def search
    @search_params = post_search_params
  end

  def search_result
    # 検索対象が "post" の場合
    if params[:search][:search_target] == "post"
      @search_params = post_search_params
      @posts = Post.post_search(@search_params)
      render :search
    # 検索対象が "user" の場合
    elsif params[:search][:search_target] == "user"
      @search_params = user_search_params
      @users = User.user_search(@search_params)
      render :search
    end
  end
  # @users = User.user_search(birthday: older_birthday..younger_birthday)

  # include public::SearchesHelper
  # def search_index
  #   # ▼ソート関連の記述
  #   sort_column    = params[:column].presence || 'id'
  #   @users         = User.joins(:user_name).search(search_params)
  #                           .order(sort_column + ' ' + sort_direction)
  #                           .paginate(page: params[:page], per_page: 10)
  #   @search_params = search_params
  # end

  private
  def post_search_params
    params.fetch(:search, {}).permit(
      :search_target,
      :action,
      :time_required_from,
      :time_required_to,
      :budget_from,
      :budget_to,
      :created_at_from,
      :created_at_to
    )
  end

  def user_search_params
    params.fetch(:search, {}).permit(
      :search_target,
      :user_name,
      :how_old_min,
      :how_old_max,
    )
  end
end
