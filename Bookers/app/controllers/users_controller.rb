class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
  	@user = current_user
    @new_book = Book.new
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @new_book = Book.new
  	@books = Book.where(user_id: params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:user_id])
    @users = @user.followings
    render :follows
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
    render :followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end
end
