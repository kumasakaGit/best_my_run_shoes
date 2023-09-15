class RanksController < ApplicationController
  def rank
    @shoe_favorite_ranks = Shoe.find(Favorite.group(:shoe_id).order('count(shoe_id) desc').limit(3).pluck(:id))
  end
end
