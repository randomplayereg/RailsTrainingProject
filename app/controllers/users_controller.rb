class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user_or_admin, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome the the club, Mr.#{@user.username}"
      redirect_to books_path
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:info] = "Your info has successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:info] = "#{@user.username} has been perished!"
      redirect_to users_path
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user_or_admin
    debugger
    if @user != current_user && current_user.admin != true
      flash[:danger] = "You don't have permission to touch other user!"
      redirect_to users_path
    end
  end

  def require_admin
    if current_user.admin == false
      flash[:info] = "Only admin can perish you!"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
