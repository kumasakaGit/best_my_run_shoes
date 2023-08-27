class ChangeDataFootWidthToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :foot_width, :integer
  end
end
