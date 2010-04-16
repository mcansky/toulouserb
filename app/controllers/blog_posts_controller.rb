class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.all
  end
  
  def show
    @blog_post = BlogPost.find(params[:id])
  end
  
  def new
    @blog_post = BlogPost.new
  end
  
  def create
    @blog_post = BlogPost.new(params[:blog_post])
    if @blog_post.save
      flash[:notice] = "Successfully created blog post."
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
    if @blog_post.update_attributes(params[:blog_post])
      flash[:notice] = "Successfully updated blog post."
      redirect_to @blog_post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    flash[:notice] = "Successfully destroyed blog post."
    redirect_to blog_posts_url
  end
end
