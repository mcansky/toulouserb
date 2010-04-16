class BlogPostsController < ApplicationController
  before_filter :require_login, :except => ["index", "show", "rss"]

  def index
    conditions = Array.new
    if !current_user
      conditions = ["published = ?", "t"]
    end
    @blog_posts = BlogPost.find_tagged_with(params[:tag], :conditions => conditions).paginate :page => params[:page] if params[:tag]
    @blog_posts = BlogPost.all(:conditions => conditions, :order => "updated_at DESC").paginate :page => params[:page] unless @blog_posts
  end
  
  def show
    @blog_post = BlogPost.find(params[:id])
    redirect_to root_url unless @blog_post.published || current_user
  end
  
  def new
    @blog_post = BlogPost.new
  end
  
  def create
    @blog_post = BlogPost.new(params[:blog_post])
    params[:blog_post][:tag_list].split(',').each do |tag|
      @blog_post.tag_list.add(tag.gsub(' ', ''))
    end
    if @blog_post.save
      flash[:notice] = "Successfully created blog_post."
      redirect_to @blog_post
    else
      render :action => 'new'
    end
  end
  
  def edit
    @blog_post = BlogPost.find(params[:id])
  end
  
  def update
    @blog_post = BlogPost.find(params[:id])
    if params[:blog_post][:tag_list]
      @blog_post.tag_list.each { |t| @blog_post.tag_list.remove(t) }
    end
    params[:blog_post][:tag_list].split(',').each do |tag|
      @blog_post.tag_list.add(tag.gsub(' ', ''))
    end
    if @blog_post.update_attributes(params[:blog_post])
      flash[:notice] = "Successfully updated blog_post."
      redirect_to @blog_post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    flash[:notice] = "Successfully destroyed blog_post."
    redirect_to blog_posts_url
  end
  
  def rss
    # Get the 10 most recent blog_posts
    @blog_posts = BlogPost.find :all, :limit => 10, :order => 'created_at DESC'
    # Title for the RSS feed
    @feed_title = "10 most recent blog_posts"
    # Get the absolute URL which produces the feed
    @feed_url = "http://" + request.host_with_port + request.request_uri
    # Description of the feed as a whole
    @feed_description = "10 most recent blog_posts"
    # Set the content type to the standard one for RSS
    response.headers['Content-Type'] = 'application/rss+xml'
    # Render the feed using an RXML template
    render :action => 'rss', :layout => false
  end
  
  def file
    @blog_post = BlogPost.find(params[:id])
    send_file @blog_post.doc.path, :type => @blog_post.doc_content_type, :disposition => 'attachment'
  end

end
