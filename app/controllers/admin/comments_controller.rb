class Admin::CommentsController < ApplicationController

  def destroy
    @shoe = Shoe.find(params[:shoe_id])
    Comment.find(params[:id]).destroy
    redirect_to admin_shoe_path(@shoe.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
