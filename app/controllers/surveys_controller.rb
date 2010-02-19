class SurveysController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    $menu_tab = 'admin'
    @surveys = Survey.find(:all, :order => 'ends_on ASC')
  end
  
  def show
    @survey = Survey.find(params[:id])
  end
  
  def new
    $menu_tab = 'admin'
    @survey = Survey.new
  end
  
  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id = current_user.id
    @survey.completion = 0
    if @survey.save
      flash[:notice] = "Successfully created survey."
      redirect_to @survey
    else
      render :action => 'new'
    end
  end
  
  def edit
    $menu_tab = 'admin'
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to edit_survey_path(@survey)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
  
  def question_type_help
    render :layout => false
  end
  
end
