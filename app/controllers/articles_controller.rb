class ArticlesController < ApplicationController
  
  before_filter :login_required, :except => [:index]
  before_filter :has_permission?, :except => [:index]
  
  def index
    redirect_to root_path
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article])
    @article.user = current_user
    if @article.save
      flash[:notice] = "Post created."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "Successfully updated post."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Successfully destroyed article."
    redirect_to root_path
  end
end
