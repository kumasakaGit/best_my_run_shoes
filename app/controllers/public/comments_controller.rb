class Public::CommentsController < ApplicationController

  def create
    @shoe = Shoe.find(params[:shoe_id])
    @comment = current_user.comments.new(comment_params)
    @comment.shoe_id = @shoe.id
    if @comment.save
      redirect_to public_shoe_path(@shoe.id)
    else
      redirect_to public_shoe_path(@shoe.id)
    end
  end

  def destroy
    @shoe = Shoe.find(params[:shoe_id])
    Comment.find(params[:id]).destroy
    redirect_to public_shoe_path(@shoe.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end