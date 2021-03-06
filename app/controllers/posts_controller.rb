class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit]
  POSTS_PER_PAGE = 6
  def index
    @page = params.fetch(:page, 0).to_i

    sql_join = "INNER JOIN users ON posts.user_id=users.id INNER JOIN friendships 
    ON (users.id=friendships.receiver_id AND friendships.asker_id=#{current_user.id})
    OR (users.id=friendships.asker_id AND friendships.receiver_id=#{current_user.id})
    OR (users.id=#{current_user.id})"
    sql_condition = "friendships.status= ?"

    all_posts = policy_scope(Post).joins(sql_join).where(sql_condition, "accepted").distinct.order('updated_at DESC')
    @number_of_pages = all_posts.count / POSTS_PER_PAGE
    @posts = all_posts.offset(@page*POSTS_PER_PAGE).limit(POSTS_PER_PAGE)

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

  
  private

  def set_post
    @post = Post.find(params[:id]) rescue not_found
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :post_id, :rich_body, photos: [])
  end


end
