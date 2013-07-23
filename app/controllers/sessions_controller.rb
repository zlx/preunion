class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to home_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
#@user = User.find_by_email(params[:email])
#if @user.password == params[:password]
#give_token
#else
#redirect_to home_path
#end
#end
#end
