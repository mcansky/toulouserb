class PagesController < ApplicationController
  layout :check_layout
  before_filter :require_admin, :except => ['show']
  def index
     @pages = Page.all
   end

   def show
     @page = Page.find(params[:id]) if params[:id].class == "Integer" || "FixNum"
     @page = Page.find_by_title_fr(params[:id].capitalize) if !@page || @page == nil
     @page = Page.find_by_title_en(params[:id].capitalize) if !@page || @page == nil
   end

   def new
     @page = Page.new
   end

   def create
     @page = Page.new(params[:page])
     if @page.save
       flash[:notice] = "Successfully created page."
       redirect_to @page
     else
       render :action => 'new'
     end
   end

   def edit
     @page = Page.find(params[:id])
   end

   def update
     @page = Page.find(params[:id])
     if @page.update_attributes(params[:page])
       flash[:notice] = "Successfully updated page."
       redirect_to @page
     else
       render :action => 'edit'
     end
   end

   def destroy
     @page = Page.find(params[:id])
     @page.destroy
     flash[:notice] = "Successfully destroyed page."
     redirect_to pages_url
   end

  private
  def check_layout
    logged_in? ? "admin" : "application"
  end
end
