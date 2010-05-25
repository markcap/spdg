class SurveyTemplatesController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    @survey_templates = SurveyTemplate.find(:all)
    $menu_tab = 'admin'
  end
  
  def show
    @survey_template = SurveyTemplate.find(params[:id])
    $menu_tab = 'admin'
  end
  
  def new
    #I'm basically setting the template's id before I save it because I need it for the question forms that get generated.
    @next_id = SurveyTemplate.last.id + 1
    @survey_template = SurveyTemplate.new
    $menu_tab = 'admin'
  end
  
  def create
    @survey_template = SurveyTemplate.new(params[:survey_template])
    @survey_template.user = current_user
    if @survey_template.save
      flash[:notice] = "Successfully created survey template."
      redirect_to @survey_template
    else
      render :action => 'new'
    end
  end
  
  def edit
    $menu_tab = 'admin'
    @survey_template = SurveyTemplate.find(params[:id])
    @next_id = @survey_template.id
  end
  
  def update
    @survey_template = SurveyTemplate.find(params[:id])
    if @survey_template.update_attributes(params[:survey_template])
      flash[:notice] = "Successfully updated survey template."
      render :action => 'edit'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey_template = SurveyTemplate.find(params[:id])
    @survey_template.destroy
    flash[:notice] = "Successfully destroyed survey template."
    redirect_to survey_templates_url
  end
end
