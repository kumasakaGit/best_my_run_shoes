class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to public_post_path(@post.id)
    else
      redirect_to public_post_path(@post.id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end
