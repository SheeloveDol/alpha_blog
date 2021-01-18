class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index 
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_whitelisting)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create 
    #byebug
    @user = User.new(user_params_whitelisting)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private

  def user_params_whitelisting
    params.require(:user).permit(:username, :email, :password)
  end

end