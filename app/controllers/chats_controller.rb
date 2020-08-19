class ChatsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @chats = policy_scope(Chat).includes(:user_chats).where(user_chats: {user: current_user});
  end

  def show
    @chats = policy_scope(Chat).includes(:user_chats).where(user_chats: {user: current_user});
    @chat = Chat.find(params[:id])
    authorize @chat
    @partner_profile = current_user == @chat.users.first ? @chat.users.last.profile : @chat.users.first.profile
    @message = Message.new
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

  def user_not_authorized(exception)
    # Send it to chat index that is specific for Chat Pundit not allowed
    flash[:error] = exception.policy.try(:error_message) || "You're not allow to see the chat"
    redirect_to chats_path 
  end

  def handle_record_not_found
    # Send it to chat index that is specific for Chat not found
    redirect_to chats_path 
  end

  private
  def chat_params
    params.require(:chat).permit(:name)
  end
end
