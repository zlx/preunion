class UsersController < ApplicationController
  before_action :find_user, except: [:edit]
  before_action :require_login, only: [:edit]

  def edit
    @user = current_user
  end

  def update
    if @user.authenticate(user_params[:current_password]) &&
      @user.update_attributes(user_params)
      redirect_to root_path, notice: t('edit_info_success')
    else
      redirect_to users_edit_path, alert: t('edit_info_fail')
    end
  end

  private
  def find_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :password, :password_confirmation, :current_password)
  end
end
