class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :shoe
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
