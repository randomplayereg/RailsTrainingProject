class UsersController < ApplicationController

  before_action :require_user, except: [:new, :show, :index, :create]
  before_action :set_user, only: [:show, :require_permission]
  before_action :require_permission, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created, you can log-in now, Mr.#{@user.username}!"
      redirect_to login_path
    else
      render 'new'
    end
  end

  def index
    #@users = User.all
    @users = User.where(admin: false).paginate(:page => params[:page], :per_page => 5)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account has been updated!'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "#{@user.username} has been deleted!"
      if current_user == @user
        cookies.delete :uid
      end
      redirect_to users_path
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_permission
      profile_owner = set_user
      if current_user != profile_owner && current_user.admin == false
        flash[:danger] = "You can't edit other's profile"
        redirect_to users_path
      end
    end
end
