class AddPhotoImageUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :photo_image_url, :string
  end
end
