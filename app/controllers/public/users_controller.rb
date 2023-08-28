class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def index
    @user = current_user
    @users = User.all
  end


  private
    def list_params
      params.require(:user).permit(:nick_name, :gender, :foot_size, :foot_width, :email, :password, :image)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
    end
end
