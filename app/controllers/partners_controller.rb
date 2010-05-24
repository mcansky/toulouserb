class PartnersController < ApplicationController
  layout :check_layout
  before_filter :require_login, :except => ["index", "show"]
  def index
    conditions = Array.new
    if !current_user
      conditions = ["published = ?", "t"]
    end
    @partners = Partner.all(:conditions => conditions).reverse.paginate :page => params[:page]
  end
  
  def show
    @partner = Partner.find(params[:id])
    redirect_to root_url unless @partner.published || current_user
  end
  
  def new
    @partner = Partner.new
  end
  
  def create
    @partner = Partner.new(params[:partner])
    if @partner.save
      flash[:notice] = "Successfully created partner."
      redirect_to @partner
    else
      render :action => 'new'
    end
  end
  
  def edit
    @partner = Partner.find(params[:id])
  end
  
  def update
    @partner = Partner.find(params[:id])
    if @partner.update_attributes(params[:partner])
      flash[:notice] = "Successfully updated partner."
      redirect_to @partner
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    flash[:notice] = "Successfully destroyed partner."
    redirect_to partners_url
  end

  private
  def check_layout
    logged_in? ? "admin" : "application"
  end
end
