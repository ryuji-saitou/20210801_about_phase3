class Public::SearchesController < ApplicationController
  def search
    # @search_params = user_search_params

    # 検索対象が "post" の場合
    if params[:search_target] == "post" || !params[:search_target].present?
      @search_params = post_search_params
      @posts = params[:search_target].present? ? Post.post_search(@search_params) : []
      render :search
    # 検索対象が "user" の場合

    elsif params[:search_target] == "user"
      sort_column    = params[:column].presence || 'id'
      @search_params = user_search_params
      @users = User.user_search(@search_params)
                   .order(sort_column + ' ' + sort_direction)
      render :search
    end
  end

  # def search_result
  #   # 検索対象が "post" の場合
  #   if params[:search][:search_target] == "post"
  #     @search_params = post_search_params
  #     @posts = Post.post_search(@search_params)
  #     render :search
  #   # 検索対象が "user" の場合
  #   elsif params[:search][:search_target] == "user"
  #     @search_params = user_search_params
  #     @users = User.user_search(@search_params)
  #     render :search
  #   end
  # end

# ===検索結果ソート=================================

  include Public::SearchesHelper

  def search_result
    # 検索対象が "post" の場合
    if params[:search][:search_target] == "post"
      @search_params = post_search_params
      @posts = Post.post_search(@search_params)
      render :search
    # 検索対象が "user" の場合

    elsif params[:search][:search_target] == "user"
      sort_column    = params[:column].presence || 'id'
      @search_params = user_search_params
      @users = User.user_search(@search_params)
                   .order(sort_column + ' ' + sort_direction)
      render :search
    end
  end

  def search_params
    params.permit(:title, :author, :publication_year_from, :publication_year_to)
  end

# ===検索結果ソート=================================










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
    if params[:search].present?
      params.fetch(:search, {}).permit(
        :search_target,
        :user_name,
        :how_old_min,
        :how_old_max,
      )
    else
      params.permit(
        :search_target,
        :user_name,
        :how_old_min,
        :how_old_max
      )
    end
  end
end
