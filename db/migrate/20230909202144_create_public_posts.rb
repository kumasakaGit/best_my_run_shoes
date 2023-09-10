class CreatePublicPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :public_posts do |t|

      t.string :name, null: false
      t.text :comment, null: false
      t.float :evaluation, null: false
      t.timestamps
    end
  end
end
