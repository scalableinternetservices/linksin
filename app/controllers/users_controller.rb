class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: :destroy
  helper_method :randomShow

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @userlist = randomShow(@user).select do |user|
      conversation = Conversation.between(user.id, @user.id)
      conversation.empty? || !conversation.first.mutual
    end
    @eventList = User.find(params[:id]).events
  end

  def randomShow(user)
    User.where.not(id: user.id).order("RANDOM()").limit(20)
  end

  def new
    @user = User.new 
    @userlist = []
    @eventList = []
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to LinksIn! Please create your profile."
      redirect_to edit_profile_path(@user.profile)
    else
      render 'new'
    end
    @userList = []
    @eventList = []
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @eventList = User.find(params[:id]).events
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end