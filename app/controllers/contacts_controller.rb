class ContactsController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  def index
    @contacts = Contact.all
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    @project = Project.find(params[:contact][:project_id])
    @contact.project = @project
    if @contact.save
      flash[:notice] = "Successfully created contact."
      redirect_to information_project_path(@project)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @contact = Contact.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Successfully updated contact."
      redirect_to information_project_path(@contact.project)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @project = @contact.project
    @contact.destroy
    flash[:notice] = "Successfully destroyed contact."
    redirect_to information_project_path(@project)
  end
  
  def email
    @contact = Contact.find(params[:contact_id])
  end
end
