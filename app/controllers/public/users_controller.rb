class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :ensure_normal_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @shoes = @user.shoes.page(params[:page]).latest
    elsif params[:old]
      @shoes = @user.shoes.page(params[:page]).old
    elsif params[:favorites]
      shoes = @user.shoes.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).size
      }.reverse
      @shoes = Kaminari.paginate_array(shoes).page(params[:page])
    else
      @shoes = @user.shoes.page(params[:page])
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
      flash[:notice] = "編集完了しました"
      redirect_to public_user_path(@user.id)
    else
      redirect_to edit_public_user_path, alert: '編集に失敗しました。空欄等が無いか確認してください。'
    end
  end

  def destroy
    ensure_normal_user
    is_matching_login_user
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
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
