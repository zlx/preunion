class UsersController < ApplicationController
  before_action :find_user

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, notice: t('edit_info_success')
    else
      redirect_to edit_user_path(@user), alert: t('edit_info_fail')
    end
  end

  private
  def find_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :password, :password_confirmation)
  end
end
