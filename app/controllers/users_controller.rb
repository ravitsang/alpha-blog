class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page:5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password) # assign the input into corresponding params
  end

end
