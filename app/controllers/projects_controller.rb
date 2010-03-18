class ProjectsController < ApplicationController
  before_filter :require_login, :except => ["index", "show"]
  def index
    @projects = Project.find_tagged_with(params[:tag]).reverse.paginate :page => params[:page] if params[:tag]
    @projects = Project.all.reverse.paginate :page => params[:page] unless @projects
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    params[:project][:tag_list].split(',').each do |tag|
      @project.tag_list.add(tag.gsub(' ', ''))
    end
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
    if params[:project][:tag_list]
      @project.tag_list.each { |t| @post.tag_list.remove(t) }
    end
    params[:project][:tag_list].split(',').each do |tag|
      @project.tag_list.add(tag.gsub(' ', ''))
    end
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
end
