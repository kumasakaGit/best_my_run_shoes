class RemoveColumnsToShoes < ActiveRecord::Migration[6.1]
  def change
    remove_column :shoes, :comment, :text
    remove_column :shoes, :evaluation, :integer
  end
end
