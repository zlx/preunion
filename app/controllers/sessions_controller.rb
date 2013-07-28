class SessionsController < ApplicationController
  def auth
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    if @user.authenticate(666666)
      redirect_to users_edit_path, notice: t('auth_success_with_notice')
    else
      redirect_to root_path, notice: t('auth_success')
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      self.current_user = @user
      redirect_to root_path, notice: t('sign_in_success')
    else
      redirect_to new_session_path, alert: t('sign_in_fail')
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: t('sign_out_success')
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].except('extra')
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
