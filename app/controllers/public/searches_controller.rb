class Public::SearchesController < ApplicationController
  def search
    @search_params = search_params
  end

  def search_result
    @search_params = search_params
    @posts = Post.post_search(@search_params)
    render :search
  end

  private
  def search_params
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
end
