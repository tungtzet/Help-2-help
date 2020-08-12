class PostsController < ApplicationController
  before_action :set_posts, only: [:show, :update, :destroy, :edit]
  # Lets have a look at all posts
  def index
    @posts = policy_scope(Post)
  end

  # Lets have a look at some specific posts
  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render new
    end
    authorize @post
  end

  def set_posts
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
