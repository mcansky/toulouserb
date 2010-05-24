# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :set_menu_vars
  before_filter :check_layout
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  def index
    conditions = Array.new
    if !current_user
      conditions = ["published = ?", "t"]
    end
    @events = Event.find(:conditions => conditions).reverse[0..4]
    @posts = BlogPost.find(:conditions => conditions).reverse[0..4]
    @tweets = Array.new
  end

  def set_menu_vars
    conditions = Array.new
    if !current_user
      conditions = ["published = ?", "t"]
    end
    @users_count = User.all.size
    @events_count = Event.find(:conditions => conditions).size
    @projects_count = Project.all.size
    @posts_count = BlogPost.find(:conditions => conditions).size
    check_layout
  end

  def require_login
		if current_user
			return true
		else
			redirect_to root_url
		end
	end
  def require_admin
    return true if current_user && current_user.is_admin?
    flash[:warning] = "Not authorized"
    redirect_to root_url
  end
	
	def about
  end
  
  def logged_in?
    return true if current_user
    return false
  end

	private
	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.record
	end

  def check_layout
    "admin" if current_user
    "application"
  end
end
