class ProfilesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update]

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

  private
  
    def create_params
      params.require(:profile).permit(:user_id)
    end
    
    def profile_params
      params.require(:profile).permit(:description, :games, :accounts)
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
      @user = get_profile(params[:id]).user
      unless @user == current_user
        flash[:danger] = "Can not edit other users' profiles."
        redirect_to(get_profile(params[:id])) 
      end
    end
end
