class Public::FavoritesController < ApplicationController

  def create
    @shoe = Shoe.find(params[:shoe_id])
    @favorite = current_user.favorites.new(shoe_id: @shoe.id)
    @favorite.save
    redirect_to public_shoe_path(@shoe.id)
  end

  def destroy
    @shoe = Shoe.find(params[:shoe_id])
    @favorite = current_user.favorites.find_by(shoe_id: @shoe.id)
    @favorite.destroy
    redirect_to public_shoe_path(@shoe.id)
  end
end
