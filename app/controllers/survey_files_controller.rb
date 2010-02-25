class SurveyFilesController < ApplicationController
  def index
    @survey_files = SurveyFile.find(:all)
  end
  
  def show
    @survey_file = SurveyFile.find(params[:id])
  end
  
  def new
    @survey_file = SurveyFile.new
  end
  
  def create
    @survey_file = SurveyFile.new(params[:survey_file])
    if @survey_file.save
      flash[:notice] = "Successfully created survey file."
      redirect_to @survey_file
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey_file = SurveyFile.find(params[:id])
  end
  
  def update
    @survey_file = SurveyFile.find(params[:id])
    if @survey_file.update_attributes(params[:survey_file])
      flash[:notice] = "Successfully updated survey file."
      redirect_to @survey_file
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey_file = SurveyFile.find(params[:id])
    @survey = @survey_file.survey
    @project = @survey.project
    @survey_file.destroy
    flash[:notice] = "Attachment removed."
    redirect_to current_survey_project_path(@project, :survey_id => @survey.id)
  end
  
  def download
    @survey_file = SurveyFile.find(params[:id])
    file = File.new(@survey_file.document.path, "r")
    send_data(file.read,
      :filename     =>  @survey_file.document_file_name,
      :type         =>  @survey_file.document_content_type,
      :disposition  =>  'inline')
  end
end
