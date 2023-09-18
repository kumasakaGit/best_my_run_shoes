class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_normal_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @shoes = Shoe.latest
    elsif params[:old]
      @shoes = Shoe.old
    elsif params[:favorites]
      @shoes = Shoe.favorites
    else
      @shoes = Shoe.where(user_id:params[:id])
    end
  end

  def edit
    ensure_normal_user
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    ensure_normal_user
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
      params.require(:user).permit(:nick_name, :gender, :foot_size, :foot_width, :profile_image)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to public_user_path(current_user.id)
      end
    end

  def ensure_normal_user
    user = User.find(params[:id])
    if user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

end
