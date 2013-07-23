class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def current_user=(user)
    @current_user = user
    session[:user] = user.try(:id)
  end
end
