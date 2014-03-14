class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  # before_filter :prepare_for_mobile

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must log in to do that."
      redirect_to root_path
    end
  end

  def access_denied
    flash[:error] = "You can't do that."
    redirect_to root_path
  end

  # private

  # def mobile_device?
  #   if session[:mobile_param]
  #     session[:mobile_param] == "1"
  #   else
  #     request.user_agent =~ /Mobile|webOS/
  #   end
  # end
  # helper_method :mobile_device?

  # def prepare_for_mobile
  #   session[:mobile_param] = params[:mobile] if params[:mobile]
  #   request.format = :mobile if mobile_device?
  # end
end
