class ChangeDataFootSizeToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :foot_size, :float
  end
end
