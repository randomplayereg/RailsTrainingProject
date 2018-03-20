class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #session[:user_id] = user.id
      cookies[:uid] = {value: user.id, expires: 1.minute.from_now}
      flash[:success] = "You have logged in successfully!"
      redirect_to root_path
    else
      flash[:danger] = "Invalid email or password"
      render 'new'
    end
  end
  def destroy
    #@current_user = session[:user_id] = nil
    cookies.delete :uid
    flash[:info] = "You have logged out!"
    redirect_to root_path
  end
end
