class UsersController < ApplicationController

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      session[:user] = @user.id
    else
      redirect_to home_path
    end
  end
end
