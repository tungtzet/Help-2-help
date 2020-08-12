class FriendshipsController < ApplicationController
  
  # def index
  #   @friendships = Friendship.all
  # end

  def create
    @friendship = Friendship.new(friendship_params)
    authorize @friendship
    receiver_profile = Profile.find(params[:profile_id])
    @friendship.receiver = receiver_profile.user
    @friendship.asker = current_user
    if @friendship.save
      redirect_to profile_path(receiver_profile)
    else
      render 'profiles/show'
    end
  end

  private
  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
