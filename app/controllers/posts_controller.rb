class PostsController < ApplicationController
  before_filter :require_login, :except => ["index", "show", "rss"]

  def index
    @posts = Post.find_tagged_with(params[:tag], :conditions => "published = true").reverse.paginate :page => params[:page] if params[:tag]
    if !current_user
      @posts = Post.all(:conditions => "published == 1").reverse.paginate :page => params[:page] unless @posts
    else
      @posts = Post.all.reverse.paginate :page => params[:page] unless @posts
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    params[:post][:tag_list].split(',').each do |tag|
      @post.tag_list.add(tag.gsub(' ', ''))
    end
    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to @post
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if params[:post][:tag_list]
      @post.tag_list.each { |t| @post.tag_list.remove(t) }
    end
    params[:post][:tag_list].split(',').each do |tag|
      @post.tag_list.add(tag.gsub(' ', ''))
    end
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to posts_url
  end
  
  def rss
    # Get the 10 most recent posts
    @posts = Post.find :all, :limit => 10, :order => 'created_at DESC'
    # Title for the RSS feed
    @feed_title = "10 most recent posts"
    # Get the absolute URL which produces the feed
    @feed_url = "http://" + request.host_with_port + request.request_uri
    # Description of the feed as a whole
    @feed_description = "10 most recent posts"
    # Set the content type to the standard one for RSS
    response.headers['Content-Type'] = 'application/rss+xml'
    # Render the feed using an RXML template
    render :action => 'rss', :layout => false
  end

end
