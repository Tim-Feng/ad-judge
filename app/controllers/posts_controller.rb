  class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
     @posts = Post.all.page(params[:page]).per(4)
    if logged_in?
      @posts = Kaminari.paginate_array(Post.where.not(id: @current_user.votes.pluck(:voteable_id).uniq).order(:up_votes).reverse).page(params[:page]).per(4)
      
      if params[:order] && params[:order] == 'up_votes'
        @posts = @posts
      elsif params[:order] && params[:order] == 'down_votes'
        @posts = Kaminari.paginate_array(Post.where.not(id: @current_user.votes.pluck(:voteable_id).uniq).order(:down_votes).reverse).page(params[:page]).per(4)
      elsif params[:order] && params[:order] == 'the_latest'
        @posts = Kaminari.paginate_array(Post.where.not(id: @current_user.votes.pluck(:voteable_id).uniq).order(:created_at).reverse).page(params[:page]).per(4)
      end  
    else
    #   @posts = Post.page(params[:page]).per(4)
      if params[:order] && params[:order] == 'up_votes'
        @posts = @posts
      elsif params[:order] && params[:order] == 'down_votes'
        @posts = @posts.order(:down_votes).page(params[:page]).per(4).reverse
      elsif params[:order] && params[:order] == 'the_latest'
        @posts = @posts.order(:created_at).page(params[:page]).per(4).reverse
      end  
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.title = params[:title]
    @post.creator = current_user
    if @post.save
      flash[:notice] = "廣告上傳成功."
      @post.up_votes = 0
      @post.down_votes = 0
      @post.save
      redirect_to posts_path
    else  
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "廣告更新完成."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    binding.pry
    if @vote.valid?
      if @vote.vote
        @post.up_votes = @post.up_votes + 1
      else 
        @post.down_votes = @post.down_votes + 1
      end
      @post.save
    end
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.js
    end
  end

  def post_voted?(post)
    Vote.all.map(&:voteable_id).include?(post.id)
  end

  private

  def post_params
    params.require(:post).permit(:url, :language, :favicon_url)
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator)
  end
end
