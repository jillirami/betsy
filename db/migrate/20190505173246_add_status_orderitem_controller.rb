class AddStatusOrderitemController < ActiveRecord::Migration[5.2]
  def change
    change_column :orderitems, :status, :string, default: "unshippped"
  end
end
