class RankingController < ApplicationController
  def index
    @users = User.order("score desc").page(params[:page]).per(20)
  end
end
