class SurveysController < ApplicationController
  include ApplicationHelper
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    $menu_tab = 'admin'
    if current_user.survey_view_type == 1 #all surveys
      @surveys = Survey.complete
    elsif current_user.survey_view_type == 2 #incomplete surveys
      @surveys = Survey.incomplete
    else
      @surveys = Survey.all
    end
  end
  
  def show

    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
      format.csv do 
        send_data @survey.generate_excel, :filename => @survey.name + "_" + @survey.ends_on.strftime('%b-%d-%Y') + '.csv'
      end
      format.pdf do 
        prawnto :prawn => { :top_margin => 10, :left_margin => 50, :right_margin=> 50}
        prawnto :filename => no_spaces(@survey.name) + "_" + @survey.ends_on.strftime('%b-%d-%Y') + '.pdf'
      end
    end
  end
  
  def new
    $menu_tab = 'admin'
    @survey = Survey.new
    @show_templates = true
    @show_multiple = true
  end
  
  def create

    if params[:multiples]
      #for multiple surveys
      project_array = []
      params[:multiples].each do |m|
        if m.last != "0"
          project_array << m.last.to_i
        end
      end
      number_of_surveys = project_array.size
    else
      number_of_surveys = 1
    end
    
    #save flag is so i don't have multiple redirects.
    save_flag = true
    number_of_surveys.times do |x|
      @survey = Survey.new(params[:survey])
      if !params[:survey][:project_id]
        @survey.project_id = project_array[x]
      end
      @survey.user_id = current_user.id
      @survey.completion = 0
      if @survey.save
        if !params[:template_questions].nil?
          params[:template_questions].sort.each do |q|
            # this is to save the template formed questions. the data comes in this form: 
            # ["0", {"question_type"=>"1", "survey_id"=>"16", "content"=>"#1"}]
            # hence why it is formed with q.last, the 2nd part of the array.
            unless q.last['destroy'].to_i == 1 
              #deleting destroy value in order to save it
              q.last.delete("destroy") 
              question = Question.new(q.last)
              question.survey = @survey
              question.save
            end
          end
        end
      else 
        save_flag = false
      end
    end
    
    if save_flag
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
      if !params[:template_questions].nil?
        params[:template_questions].sort.each do |q|
          # this is to save the template formed questions. the data comes in this form: 
          # ["0", {"question_type"=>"1", "survey_id"=>"16", "content"=>"#1"}]
          # hence why it is formed with q.last, the 2nd part of the array.
          unless q.last['destroy'].to_i == 1 
            #deleting destroy value in order to save it
            q.last.delete("destroy") 
            question = Question.new(q.last)
            question.survey = @survey
            question.save
          end
        end
      end
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
      render :partial => 'survey_template', :locals => { :id => params[:template]}
  end
  
  def render_multiple_projects
      render :partial => 'multiple_projects'
  end
  
end
