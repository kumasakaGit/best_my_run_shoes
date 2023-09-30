class Public::ShoesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :search]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @shoe = Shoe.new
    @image_url = params[:image_url]
    @shoe_url = params[:shoe_url]
    @user = current_user
  end

  def index
    @user = current_user
    if params[:latest]
      @shoes = Shoe.page(params[:page]).latest
    elsif params[:old]
      @shoes = Shoe.page(params[:page]).old
    elsif params[:favorites]
      shoes = Shoe.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).size
      }.reverse
      @shoes = Kaminari.paginate_array(shoes).page(params[:page])
    else
      @shoes = Shoe.page(params[:page])
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
    @comment = Comment.new
    @user = @shoe.user

  end

  def create
    @shoe = Shoe.new(shoe_params)
    @shoe.user = current_user
    if @shoe.save
      flash[:notice] = "投稿しました！"
      redirect_to public_user_path(current_user.id)
    else
      flash[:notice] = "投稿エラーが起きました"
      render :new
    end
  end

  def edit
    is_matching_login_user
    @shoe = Shoe.find(params[:id])
    @user = current_user
  end

  def update
    is_matching_login_user
    @shoe = Shoe.find(params[:id])
    if @shoe.update(shoe_params)
      flash[:notice] = "投稿の編集が完了しました！"
      redirect_to public_shoe_path(@shoe.id)
    else
      render :edit
    end
  end

  def destroy
    is_matching_login_user
    @shoe = Shoe.find(params[:id])
    @shoe.destroy
    redirect_to public_user_path(current_user.id)
  end

  def search
    @shoe = Shoe
    return unless params[:keyword]
    unless params[:keyword].empty?
      @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    else
      path = Rails.application.routes.recognize_path(request.referer)
      if path[:controller] == "public/users" && path[:action] == "show"
        flash[:alert] = 'キーワードを入力してください'
        redirect_to request.referer
      else
        flash.now[:alert] = 'キーワードを入力してください'
      end
    end
  end

  private

  def shoe_params
    params.require(:shoe).permit(:name, :comment, :evaluation, :photo_image_url, :rakuten_shoes_url)
  end

  def is_matching_login_user
    @shoe = Shoe.find(params[:id])
    unless @shoe.user == current_user
      redirect_to public_user_path(current_user.id)
    end
  end
end