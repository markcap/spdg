class SurveysController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    $menu_tab = 'admin'
    if current_user.survey_view_type == 1 #all surveys
      @surveys = Survey.all
    elsif current_user.survey_view_type == 2 #incomplete surveys
      @surveys = Survey.incomplete.paginate(:per_page => 20, :page => params[:page])
    else
      @surveys = Survey.by_end.paginate(:per_page => 20, :page => params[:page])
    end
  end
  
  def show
    @survey = Survey.find(params[:id])
  end
  
  def new
    $menu_tab = 'admin'
    @survey = Survey.new
    #I'm basically setting the template's id before I save it because I need it for the question forms that get generated.
    @next_id = Survey.by_id.last.id + 1
    @show_templates = true
  end
  
  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id = current_user.id
    @survey.completion = 0
    if !params[:template_questions].nil?
      params[:template_questions].sort.each do |q|
        # this is to save the template formed questions. the data comes in this form: 
        # ["0", {"question_type"=>"1", "survey_id"=>"16", "content"=>"#1"}]
        # hence why it is formed with q.last, the 2nd part of the array.
        unless q.last['destroy'].to_i == 1 
          #deleting destroy value in order to save it
          q.last.delete("destroy") 
          question = Question.new(q.last)
          question.save
        end
      end
    end
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
    @next_id = @survey.id
  end
  
  def update
    @survey = Survey.find(params[:id])
    if !params[:template_questions].nil?
      params[:template_questions].sort.each do |q|
        # this is to save the template formed questions. the data comes in this form: 
        # ["0", {"question_type"=>"1", "survey_id"=>"16", "content"=>"#1"}]
        # hence why it is formed with q.last, the 2nd part of the array.
        unless q.last['destroy'].to_i == 1 
          #deleting destroy value in order to save it
          q.last.delete("destroy") 
          question = Question.new(q.last)
          question.save
        end
      end
    end
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
  
  def render_template
      render :partial => 'survey_template', :locals => { :id => params[:template], :survey_id => params[:survey_id] }
  end
  
end
