class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(user_id: current_user.id, post_id: params[:post_id])
    @favorite.save
    redirect_to public_post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    @favorite.destroy
    redirect_to public_post_path(@post.id)
  end
end
