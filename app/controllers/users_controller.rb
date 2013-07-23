class UsersController < ApplicationController
  before_action :find_user

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      self.current_user = @user
      redirect_to root_path
    else
      redirect_to edit_user_path(@user)
    end
  end

  private
  def find_user
    @user ||= User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname)
  end
end
