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