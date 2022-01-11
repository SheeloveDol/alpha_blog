class UsersController < ApplicationController
  # This requires that a user is logged in to perform these actions
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # This, (from application_controller.rb) reinforces the 'logged-in' requirement even when using the url. ie: ["/users/2/edit"]
  before_action :require_user, only: [:edit, :update]

  # This makes sure that logged-in users can ONLY edit their OWN profiles when trying to do so from the url
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index 
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
    
  end

  def update
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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Sheelove's Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user #important otherwise the application will break and we will have to clear the cookies or hardcode another user into sessions
    flash[:notice] = "Your account and all associated articles have been successfully deleted"
    redirect_to articles_path
  end



  
  private

  def user_params_whitelisting
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # This makes sure that logged-in users can ONLY edit their OWN profiles when trying to do so from the url
  # Added "&& !current_user.admin?" to allow admin to have editing and deleting ability.
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile"
      redirect_to @user
    end
  end

end