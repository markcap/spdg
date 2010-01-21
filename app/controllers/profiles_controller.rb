class ProfilesController < ApplicationController
  def index
    @profiles = Profile.find(:all)
  end
  
  def show
    @profile = Profile.find(params[:id])
  end
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user
    if @profile.save
      flash[:notice] = "Thank you for your information."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Successfully updated profile."
      redirect_to @profile
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    flash[:notice] = "Successfully destroyed profile."
    redirect_to profiles_url
  end
end
