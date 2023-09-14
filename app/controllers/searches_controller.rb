class SearchesController < ApplicationController
   before_action :authenticate_user!

  def search
    if @shoes = params[:keyword].present? ? Shoe.search(params[:name]).posts : Shoe.all
    end
  end
end
