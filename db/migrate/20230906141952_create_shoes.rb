class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :comment, null: false
      t.float :evaluation, null: false
      t.string :photo_image_url, null: false
      t.timestamps
    end
  end
end
