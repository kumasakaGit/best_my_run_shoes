class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
end
