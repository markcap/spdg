class GoalsController < ApplicationController
  
  before_filter :login_required, :except => [:index]
  before_filter :has_permission?, :except => [:index]
  
  def index
    $menu_tab = 'goals'
    @goals = Goal.first
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(params[:goal])
    if @goal.save
      flash[:notice] = "Successfully created goal."
      redirect_to @goal
    else
      render :action => 'new'
    end
  end
  
  def edit
    $menu_tab = 'admin'
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      flash[:notice] = "Successfully updated goal."
      redirect_to goals_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "Successfully destroyed goal."
    redirect_to goals_url
  end
end
