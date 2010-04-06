class ProjectsController < ApplicationController
  
  before_filter :login_required, :except => :index
  before_filter :has_permission?, :except => :index
  
  
  def index
    $menu_tab = 'projects'
    @goals = GoalHeader.find(:all, :order => 'position ASC')
    @other_projects = Project.no_goal
  end
  
  def show
    $menu_tab = 'my home'
    @project_tab = "home"
    @project = Project.find(params[:id])
    @active_surveys = @project.active_surveys
    @last_survey = @project.surveys.inactive.first
  end
  
  def new
    $menu_tab = 'admin'
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.goal_header_id.nil?
      @project.goal_header_id = 0
    end
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to manage_projects_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to information_project_path(@project)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
  
  def information
    $menu_tab = 'my home'
    @project_tab = "information"
    @project = Project.find(params[:id])
    @contact = Contact.new
  end
  
  def add_user
  end
  
  def add_user_commit
    @project = Project.find(params[:id])
    @user = User.find(params[:user_id].to_i)
    @users = @project.users
    if params[:change] == 'add'
      if @project.users.include?(@user)
        flash[:error] = "Member is already in this project's user list."
        redirect_to @project and return
      else 
        @users << @user
        flash[:notice] = "Successfully added " + @user.profile.firstname.to_s + " " + @user.profile.lastname.to_s
      end
    else
      @users.delete(@user)
      flash[:notice] = "Successfully removed " + @user.profile.firstname.to_s + " " + @user.profile.lastname.to_s
    end
    
    @project.users = @users
    if @project.save
      redirect_to @project
    else
      render :action => 'show'
    end
  end
  
  def current_survey
    
    $menu_tab = 'my home'
    @project_tab = "current_survey"
    @project = Project.find(params[:id])
    
    #This is basically permissions for this method
    if !params[:survey_id].nil?
      survey = Survey.find(params[:survey_id].to_i)
      if survey.project != @project || survey.ends_on < Time.now
        redirect_to error_url
      end
    end
  end
  
  def past_surveys
    $menu_tab = 'my home'
    @project_tab = "past_surveys"
    @project = Project.find(params[:id])
    @surveys = @project.surveys.inactive
  end
  
  def submitanswers
    @project_tab = "current_survey"
    @project = Project.find(params[:id])
    params[:answer_hash].each do |e|
      answer = Answer.find(e[0].to_i)
      answer.content = e[1]
      answer.save
      @survey =  answer.question.survey
    end
    
    #There's a better way to do this but time's a-ticking
    if !params[:survey_file1][:document].nil?
      @survey_file = SurveyFile.new(params[:survey_file1])
      @survey_file.save
    end
    if !params[:survey_file2][:document].nil?
      @survey_file = SurveyFile.new(params[:survey_file2])
      @survey_file.save
    end
    if !params[:survey_file3][:document].nil?
      @survey_file = SurveyFile.new(params[:survey_file3])
      @survey_file.save
    end
    
  end
  
  def auto_complete_for_profile_lastname
    #This takes in the value of the autocomplete field
    name = params[:profile][:lastname] 
    
    #Search for all matching first and last names
    @names = 
    Profile.find(:all, 
      :conditions => [ 'LOWER(lastname) LIKE ? OR LOWER(firstname) LIKE ?',
      name.downcase + '%', name.downcase + '%' ], 
      :order => 'lastname ASC',
      :limit => 100) unless name.blank?
      
    #The following iterations make a new array with people who had the search value in their last name first, followed by
    #people who have it in their first name.
     
    @new_names = []
    @names.each do |n|
      if n.lastname.starts_with?(name.capitalize)
        @new_names << n
      end
    end
    
    @names.each do |n|
      if !n.lastname.starts_with?(name.capitalize)
        @new_names << n
      end
    end
  
    render :partial => "quicksearch", :locals => {:project_id => params[:project_id]}
  end
  
  def auto_complete_for_profile_email
    #This takes in the value of the autocomplete field
    name = params[:profile][:email] 
    
    #Search for all matching first and last names
    @names = 
    Profile.find(:all, 
      :conditions => [ 'LOWER(email) LIKE ?',
      name.downcase + '%'], 
      :order => 'email ASC',
      :limit => 100) unless name.blank?

    @new_names = @names
  
    render :partial => "quicksearch", :locals => {:project_id => params[:project_id]}
  end
  
end
