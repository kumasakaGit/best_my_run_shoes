class Admin::UsersController < ApplicationController
  before_action :ensure_normal_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @shoes = Shoe.where(user_id:params[:id]).latest
    elsif params[:old]
      @shoes = Shoe.where(user_id:params[:id]).old
    elsif params[:favorites]
      @shoes = Shoe.where(user_id:params[:id]).favorites
    else
      @shoes = Shoe.where(user_id:params[:id])
    end
  end

  def edit
    ensure_normal_user
    @user = User.find(params[:id])
  end

  def update
    ensure_normal_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集完了しました"
      redirect_to admin_user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    ensure_normal_user
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:nick_name, :gender, :foot_size, :foot_width, :profile_image)
    end

    def ensure_normal_user
      user = User.find(params[:id])
      if user.email == 'guest@example.com'
        redirect_to admin_users_path, alert: 'ゲストユーザーの更新・削除はできません。'
      end
    end

end
