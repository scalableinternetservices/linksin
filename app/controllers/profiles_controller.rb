class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def new
    @profile = Profile.new()
  end

  def create
    @profile = Profile.new(create_params)
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @user = @profile.user
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def destroy
    Profile.find(params[:id]).destroy
  end

  private
  
    def create_params
      params.require(:profile).permit(:user_id)
    end
    
    def profile_params
      params.require(:profile).permit(:description)
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
      @user = Profile.find(params[:id]).user
      redirect_to(root_url) unless @user == current_user
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
