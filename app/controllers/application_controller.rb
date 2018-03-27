class ApplicationController < ActionController::Base
  #protect_from_forgery unless: -> { request.format.json? }
  #protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    #@current_user ||= session[:user_id] &&User.find_by(id: session[:user_id])
    @current_user ||= User.find(cookies[:uid]) if cookies[:uid]
  end

  def logged_in?
    !!cookies[:uid]
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must log in to perform that action!"
      redirect_to root_path
    end
  end
end
