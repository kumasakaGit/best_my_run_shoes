class Admin::ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
  end

  def show
    @shoe = Shoe.find(params[:id])
    @comment = Comment.new
    @user = @shoe.user
  end

  def edit
    @shoe = Shoe.find(params[:id])
    @user = @shoe.user
  end

  def update
    @shoe = Shoe.find(params[:id])
    if @shoe.update(shoe_params)
      flash[:notice] = "投稿の編集が完了しました！"
      redirect_to admin_shoe_path(@shoe.id)
    else
      render :edit
    end
  end

  def destroy
    @shoe = Shoe.find(params[:id])
    @user = @shoe.user
    @shoe.destroy
    redirect_to admin_user_path(@user.id)
  end

  private

  def shoe_params
    params.require(:shoe).permit(:name, :comment, :evaluation, :photo_image_url)
  end
end
