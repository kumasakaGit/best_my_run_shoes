class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to public_post_path(@post.id)
    else
      redirect_to public_post_path(@post.id)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to public_post_path(@post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
