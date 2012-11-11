class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def index
    #@users = User.order("name DESC").paginate(page: params[:page])
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    user = User.find(params[:id])
    
    name = user.name
    flash[:success] = "User #{name} destroyed."
    
    user.destroy
    redirect_to users_url
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def correct_user
      accessed_user = User.find(params[:id])
      if not current_user?(accessed_user)
        flash[:error] = "You do not have authorization."
        redirect_to user_path(accessed_user)
      end
    end
    
    def admin_user
      if not current_user.admin?
        flash[:error] = "You do not have authorization."
        redirect_to(root_path) 
      end
    end
end
