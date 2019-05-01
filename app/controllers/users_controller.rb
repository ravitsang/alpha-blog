class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the alpha blod #{@user.username}"
      redirect_to articles_path
    else
      render 'new' #  the error will be show in the error partial when load the page again
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password) # assign the input into corresponding params
  end


end
