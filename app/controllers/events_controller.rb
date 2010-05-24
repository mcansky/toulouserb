class EventsController < ApplicationController
  layout :check_layout
  before_filter :require_login, :except => ["index", "show", "rss"]

  def index
    conditions = Array.new
    if !current_user
      conditions = ["published = ?", "t"]
    end
    @events = Event.find_tagged_with(params[:tag], :conditions => conditions).paginate :page => params[:page] if params[:tag]
    @events = Event.all(:conditions => conditions, :order => "e_date DESC").paginate :page => params[:page] unless @events
  end

  def show
    @event = Event.find(params[:id])
    redirect_to root_url unless @event.published || current_user
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    params[:event][:tag_list].split(',').each do |tag|
      @event.tag_list.add(tag.gsub(' ', ''))
    end
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to @event
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if params[:event][:tag_list]
      @event.tag_list.each { |t| @event.tag_list.remove(t) }
    end
    params[:event][:tag_list].split(',').each do |tag|
      @event.tag_list.add(tag.gsub(' ', ''))
    end
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to events_url
  end

  def rss
    # Get the 10 most recent events
    @events = Event.find :all, :limit => 10, :conditions => ["published = ?", "t"], :order => 'created_at DESC'
    # Title for the RSS feed
    @feed_title = "10 most recent events"
    # Get the absolute URL which produces the feed
    @feed_url = "http://" + request.host_with_port + request.request_uri
    # Description of the feed as a whole
    @feed_description = "10 most recent events"
    # Set the content type to the standard one for RSS
    response.headers['Content-Type'] = 'application/rss+xml'
    # Render the feed using an RXML template
    render :action => 'rss', :layout => false
  end

  def file
    @event = Event.find(params[:id])
    send_file @event.doc.path, :type => @event.doc_content_type, :disposition => 'attachment'
  end

  private
  def check_layout
    logged_in? ? "admin" : "application"
  end

end
