class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @params = params[:disease]
    @profiles = policy_scope(Profile)
    @profiles = policy_scope(Profile).global_search(@params).order(created_at: :desc) if @params.present?
    # raise
  end

  def show
    # User.joins(:posts).where(posts: { user: current_user })
    authorize @profile
    @posts = Post.where(user: @profile.user)
    # CONDITION FOR FRIENDSHIP BUTTON
    if Friendship.find_by(asker: current_user, receiver: @profile.user)
      @friendship = Friendship.find_by(asker: current_user, receiver: @profile.user)
    elsif Friendship.find_by(receiver: current_user, asker: @profile.user)
      @friendship = Friendship.find_by(receiver: current_user, asker: @profile.user)
    else
      @friendship = Friendship.new
    end
    #CONDITION FOR CHAT/MESSAGE BUTTON
    common_chats = current_user.chats & @profile.user.chats
    if common_chats.empty?
      @chat = Chat.new
    else
      @chat = common_chats.first
    end
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      # UserDisease.create(profile: @profile, disease: Disease.find(params[:profile][:disease]))
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
