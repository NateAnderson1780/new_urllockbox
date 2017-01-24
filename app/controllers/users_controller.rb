class UsersController < ApplicationController
  skip_before_action :require_login
  
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Welcome to URLLOCKBOX !!!!'
      redirect_to :root
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to :signup
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
