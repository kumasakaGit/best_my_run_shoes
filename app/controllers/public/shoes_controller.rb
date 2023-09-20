class Public::ShoesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :search]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @shoe = Shoe.new
    @image_url = params[:image_url]
    @user = current_user
  end

  def index
    @user = current_user
    if params[:latest]
      @shoes = Shoe.latest
    elsif params[:old]
      @shoes = Shoe.old
    elsif params[:favorites]
      p "#############"
      @shoes = Shoe.favorites
      p @shoes
    else
      @shoes = Shoe.all
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
      puts @shoe.errors.full_messages.to_sentence
      flash[:notice] = "投稿エラーが起きました"
      redirect_to public_user_path(current_user.id)
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
    if params[:keyword]
      @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  private

  def shoe_params
    params.require(:shoe).permit(:name, :comment, :evaluation, :photo_image_url)
  end

  def is_matching_login_user
    @shoe = Shoe.find(params[:id])
    unless @shoe.user == current_user
      redirect_to public_user_path(current_user.id)
    end
  end
end