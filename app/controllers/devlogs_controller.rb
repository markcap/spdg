class DevlogsController < ApplicationController
  
  $menu_tab = 'admin'
  def index
    @devlogs = Devlog.find(:all, :order => 'updated_at DESC').paginate(:per_page => 15, :page => params[:page])
  end
  
  def show
    @devlog = Devlog.find(params[:id])
  end
  
  def new
    @devlog = Devlog.new
  end
  
  def create
    @devlog = Devlog.new(params[:devlog])
    if @devlog.save
      flash[:notice] = "Successfully created devlog."
      redirect_to devlogs_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @devlog = Devlog.find(params[:id])
  end
  
  def update
    @devlog = Devlog.find(params[:id])
    if @devlog.update_attributes(params[:devlog])
      flash[:notice] = "Successfully updated devlog."
      redirect_to @devlog
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @devlog = Devlog.find(params[:id])
    @devlog.destroy
    flash[:notice] = "Successfully destroyed devlog."
    redirect_to devlogs_url
  end
end
