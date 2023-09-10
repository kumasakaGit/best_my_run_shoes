class AddColumnsToShoes < ActiveRecord::Migration[6.1]
  def change
    add_column :shoes, :comment, :text
    add_column :shoes, :evaluation, :integer
  end
end
