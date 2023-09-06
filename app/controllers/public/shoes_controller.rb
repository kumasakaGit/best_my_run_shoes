class Public::ShoesController < ApplicationController

  def search
    if params[:keyword]
      @shoes = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end
