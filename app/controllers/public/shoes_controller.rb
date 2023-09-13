class Public::ShoesController < ApplicationController

  def search
    @post = Post
    if params[:keyword]
      @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end