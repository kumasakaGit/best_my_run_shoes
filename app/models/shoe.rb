class Shoe < ApplicationRecord
  has_one_attached :image
  has_many :post, dependent: :destroy
end
