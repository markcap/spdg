class ProjectsController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  $menu_tab = 'My Project'
  
  def index
    $menu_tab = 'projects'
    @projects = Project.find(:all, :order => 'position ASC')
  end
  
  def show
    @project_tab = "home"
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
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
      redirect_to @project
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
    @project_tab = "information"
    @project = Project.find(params[:id])
  end
end
