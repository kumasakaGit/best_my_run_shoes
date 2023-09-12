class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
    @image_url = params[:image_url]
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "投稿しました！"
      redirect_to public_user_path(current_user.id)
    else
      puts @post.errors.full_messages.to_sentence
      flash[:notice] = "投稿エラーが起きました"
      redirect_to public_user_path(current_user.id)
    end
  end

  def edit
    is_matching_login_user
    @post = Post.find(params[:id])
  end

  def update
    is_matching_login_user
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の編集が完了しました！"
      redirect_to public_user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:name, :comment, :evaluation, :photo_image_url)
  end

  def is_matching_login_user
    user = User(params[:id])
    unless user.id == current_user.id
      redirect_to public_user_path(current_user.id)
    end
  end

end
