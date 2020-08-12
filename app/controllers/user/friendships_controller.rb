class User::FriendshipsController < ApplicationController
  def index
    @asker_friendships = policy_scope([:user, Friendship]).where(asker: current_user)
    @receiver_friendships = policy_scope([:user, Friendship]).where(receiver: current_user)
  end

  def update
    @friendship = Friendship.find(params[:id])
    authorize [:user, @friendship]
    # raise
    if @friendship.update(friendship_params)
      redirect_to  user_friendships_path(@friendship)
    else
      render 'user/friendships/index'
    end
    
  end

  private
  def friendship_params
    params.require(:friendship).permit(:status)
  end
end