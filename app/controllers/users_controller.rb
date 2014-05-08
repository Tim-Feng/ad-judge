class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are registered."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post_vote_true = Kaminari.paginate_array(Post.where(id: @user.votes.where(vote: true).pluck(:voteable_id).uniq).order(:up_votes).reverse).page(params[:page]).per(6)
    @post_vote_false = Kaminari.paginate_array(Post.where(id: @user.votes.where(vote: false).pluck(:voteable_id).uniq).order(:down_votes).reverse).page(params[:page]).per(6)

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allow to do that."
      redirect_to root_path
    end
  end
end