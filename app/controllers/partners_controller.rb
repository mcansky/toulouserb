class PartnersController < ApplicationController
  def index
    @partners = Partner.all
  end
  
  def show
    @partner = Partner.find(params[:id])
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
end
