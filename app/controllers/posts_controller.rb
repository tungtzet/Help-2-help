class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit]
  # Lets have a look at all posts
  def index
    @posts = policy_scope(Post)
    # .where.not(user: current_user)
    # raise
  end

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

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    authorize @post
    redirect_to posts_path
  end

  def set_post
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id, photos: [])
  end


end
