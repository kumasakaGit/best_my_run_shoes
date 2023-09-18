class Shoe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  def self.favorites
    favorite_shoes = Shoe.joins(:favorites)
    zero_favorite_shoes = Shoe.all - favorite_shoes
    favorite_shoes.group(:id).order('count(favorites.shoe_id) desc') + zero_favorite_shoes
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)
    where("name LIKE ?", "%#{keyword}%")
  end
end
