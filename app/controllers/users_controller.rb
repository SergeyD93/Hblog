class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.login
  end

  private
  def user_params
    params.require(:user).permit(:login, :avatar_link,
                                 :password, :password_confirmation)
  end
end
