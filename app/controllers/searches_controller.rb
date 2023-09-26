class SearchesController < ApplicationController

  def search
    if params[:latest]
      @shoes = Shoe.latest
    elsif params[:old]
      @shoes = Shoe.old
    elsif params[:favorites]
      @shoes = Shoe.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).size
      }.reverse
    else
      @shoes = Shoe.all
    end

    if params[:keyword] && @shoes.class == Array
      @shoes = @shoes.select{|shoe| shoe.name.include?(params[:keyword]) }
    elsif params[:keyword]
      @shoes = @shoes.search(params[:keyword])
    end
    @keyword = params[:keyword]
  end
end