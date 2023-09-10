class Public::ShoesController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @shoe = Shoe.new
    @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
  end

  def index
    @shoes = Shoe.all
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def create
    @shoe = Shoe.new(shoe_params)
    @user = @shoe.user
    if @shoe.save
      flash[:notice] = "投稿しました！"
      redirect_to public_user_path(current_user.id)
    else
      render public_user_path(current_user.id)
    end
  end

  def edit
    is_matching_login_user
    @shoe = Shoe.find(params[:id])
  end

  def update
    is_matching_login_user
    @shoe = Shoe.find(params[:id])
    if @shoe.update(shoe_params)
      flash[:notice] = "投稿の編集が完了しました！"
      redirect_to public_user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @shoe = Shoe.find(params[:id])
    @shoe.destroy
    redirect_to public_user_path(current_user.id)
  end

  def search
    @post = Post
    if params[:keyword]
      @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  private

  def shoe_params
    params.require(:shoe).permit(:image)
  end

  def is_matching_login_user
    shoe = Shoe(params[:id])
    unless shoe.id == current_user.id
      redirect_to public_user_path(current_user.id)
    end
  end
end
