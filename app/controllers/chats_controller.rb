class ChatsController < ApplicationController
  
  def index
    @chats = policy_scope(Chat).includes(:user_chats).where(user_chats: {user: current_user});
  end

  def show
    @chat = Chat.find(params[:id])
    @partner_profile = current_user == @chat.users.first ? @chat.users.last.profile : @chat.users.first.profile
    @message = Message.new
    authorize @chat
  end
  def create
    @chat = Chat.new
    authorize @chat
    profile = Profile.find(params[:profile_id])
    if @chat.save
      UserChat.create(chat: @chat, user: current_user)
      UserChat.create(chat: @chat, user: profile.user)
      redirect_to chat_path(@chat)
    else
      render 'profiles/show'
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:name)
  end
end
