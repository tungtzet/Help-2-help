class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :new, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @profiles = policy_scope(Profile)
  end

  def show
    authorize @profile
    @friendship = Friendship.new
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile)
    else
      render new
    end
    authorize @profile
  end

  def edit
    authorize @profile
  end

  def update
    authorize @profile
    if @profile.update(profile_params)
      # raise
      redirect_to profile_path(@profile)
    else
      render new
    end
  end

  def destroy
    @profile.destroy
    render show
  end

 

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :address, :age, :native_language, :second_language, :photo)
  end
end
