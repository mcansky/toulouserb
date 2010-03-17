class PostsController < ApplicationController
  before_filter :require_login, :except => ["index", "show"]

  def index
    @posts = Post.find_tagged_with(params[:tag]).reverse if params[:tag]
    @posts = Post.all.reverse.paginate :page => params[:page], :per_page => 2 unless @posts
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
end
