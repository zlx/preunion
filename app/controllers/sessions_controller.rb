class SessionsController < ApplicationController
  before_action :find_user, only: [:destroy]

  def auth
    @user = User.find_or_create_from_auth_hash(auth_hash)
    redirect_to edit_user_path(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: user_params[:name])
    if @user && @user.authenticate(user_params[:password])
      self.current_user = @user
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].except('extra')
  end

  def find_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password)
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
