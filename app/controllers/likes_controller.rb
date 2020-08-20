class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You already liked."
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to posts_path(anchor: "post-#{@post.id}")
    authorize @post
  end

  def destroy
    authorize @like
    if !(already_liked?)
      flash[:notice] ="Cannot unlike"
    else
      @like.destroy
    end
    redirect_to posts_path(anchor: "post-#{@post.id}")
  end

  private

  def find_like
    @like = @post.likes.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
end
