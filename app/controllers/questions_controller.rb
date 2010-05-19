class QuestionsController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    @questions = Question.find(:all)
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    @question = Question.new
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end
  
  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Successfully created question."
      redirect_to @question
    else
      render :action => 'new'
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Successfully updated question."
      redirect_to @question
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully destroyed question."
    redirect_to questions_url
  end
end
