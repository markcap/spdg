class ResourcesController < ApplicationController
  
  before_filter :login_required, :except => [:index, :download]
  before_filter :has_permission?, :except => [:index, :download]
  
  def index
    $menu_tab = 'resources'
    @resources = Resource.all
    @resource_header = ResourceHeader.new
    @headers = ResourceHeader.by_position
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
  
  def new
    @resource = Resource.new
  end
  
  def create
    @resource = Resource.new(params[:resource])
    # determining end position.
    header_resources = Resource.find_all_by_resource_header_id(params[:resource][:resource_header_id], :order => 'position ASC')
    if header_resources.empty?
      @resource.position = 1
    else
      @resource.position = (header_resources.last.position.to_i + 1)
    end
    if @resource.save
      flash[:notice] = "Successfully created resource."
      redirect_to admin_manage_resources_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @resource = Resource.find(params[:id])
  end
  
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:notice] = "Successfully updated resource."
      redirect_to admin_manage_resources_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    flash[:notice] = "Successfully destroyed resource."
    redirect_to admin_manage_resources_path
  end
  
  def download
    @resource = Resource.find(params[:id])
    file = File.new(@resource.document.path, "r")
    send_data(file.read,
      :filename     =>  @resource.document_file_name,
      :type         =>  @resource.document_content_type,
      :disposition  =>  'inline')
  end
  
end
