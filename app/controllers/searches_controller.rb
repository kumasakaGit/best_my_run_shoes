class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:latest]
      @shoes = Shoe.latest
    elsif params[:old]
      @shoes = Shoe.old
    else
      @shoes = Shoe.all
    end

    if params[:keyword]
      @shoes = @shoes.search(params[:keyword])
    end
    @keyword = params[:keyword]
  end
end
