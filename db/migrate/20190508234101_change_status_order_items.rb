class ChangeStatusOrderItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :orderitems, :status
  end
end
