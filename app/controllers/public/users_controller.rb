class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @users = User.all
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to public_user_path(@user.id)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:nick_name, :gender, :foot_size, :foot_width, :image)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to public_user_path(current_user.id)
      end
    end
end
