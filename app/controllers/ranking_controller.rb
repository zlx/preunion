class RankingController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @page = params[:page] || 1
    @users = User.order(sort_column + " " + sort_direction).page(@page).per(20)
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "score"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
