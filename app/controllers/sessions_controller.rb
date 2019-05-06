class SessionsController < ApplicationController
  def new
  end

  def create
    #debugger
    #render'new'
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "You have successfully logged in"
      session[:user_id] = user.id # set the user id in the session hash and as signed in
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = "You have logged out"
    redirect_to root_path
  end
end
