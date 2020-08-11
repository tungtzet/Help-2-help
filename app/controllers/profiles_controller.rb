class ProfilesController < ApplicationController
  before_action :set_profile, only: [:index, :show, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @profiles = policy_scope(Profile)
  end

  def show
    authorize @profile
  end

  def new
    authorize @profile
  end

  def edit
  end

  def update
  end

  def destroy
    @profile.destroy
    render show
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :bio, :address, :age, :native_language, :second_language, :user_id)
  end
end
