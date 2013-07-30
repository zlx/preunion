class RankingController < ApplicationController
  def index
    @users = User.all
  end
end
