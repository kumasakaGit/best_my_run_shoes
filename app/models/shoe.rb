class Shoe < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :favorites, -> { find(Favorite.group(:shoe_id).order('count(shoe_id) desc').pluck(:shoe_id)) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)
    where("name LIKE ?", "%#{keyword}%")
  end
end
