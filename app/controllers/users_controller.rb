class UsersController < ApplicationController
  before_filter :require_login, :except => ["new", "create"]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new if User.all.size < 1
    redirect_to root_url unless @user
  end
  
  def create
    redirect_to root_url unless params[:user] && User.all.size < 1
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User successfully created."
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated successfully."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User destroyed successfully."
    redirect_to users_url
  end
end