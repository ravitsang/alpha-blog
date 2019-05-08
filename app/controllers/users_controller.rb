class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show ,:destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # give the user id to session hash means the user signed in
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new' #  the error will be show in the error partial when load the page again
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page:5)
  end

  def destroy
    if current_user != @user
      @user.destroy
      flash[:danger] = "User and all articles created by user have been deleted"
    else
      flash[:danger] = "You cant delete yourself!"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password) # assign the input into corresponding params
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admin user can perform that action"
      redirect_to root_path
    end
  end


end
