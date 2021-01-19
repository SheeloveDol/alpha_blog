class ArticlesController < ApplicationController
  # This is refactored code that was showing up ain all the "#actions" below:
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # This will require that a user is logged in to be able to perform the following actions
  # We defined this the [application_controller.rb which this controller inherits from]
  before_action :require_user, except: [:show, :index]
  
  # This makes sure that only the article's creator can perform these actions
  before_action :require_same_user, only: [:edit, :update, :destroy]



  def show
  end

  def index 
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create 
    @article = Article.new(article_params_whitelisting)
    @article.user = current_user 
    if @article.save
      flash[:notice] = "Article was successfully created"
    redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params_whitelisting)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else 
      render 'edit'
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end



  private 

  # Repeated code blocks are put inside 'private methods' and are called above
  def set_article
    @article = Article.find(params[:id])
  end

  # This whitelists the article's parameters so that we can use them in our 'create' action
  def article_params_whitelisting
    params.require(:article).permit(:title, :description)
  end

  # This makes sure that logged in users can ONLY edit their OWN articles
  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end