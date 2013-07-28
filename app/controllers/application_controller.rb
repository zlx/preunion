class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def current_user=(user)
    @current_user = user
    session[:user] = user.try(:id)
  end

  def require_login
    if !current_user
      flash[:error] = t('need_authenticate')
      redirect_to new_session_path
    end
  end
end
