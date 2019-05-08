class AddBooleanStatusOrderitems < ActiveRecord::Migration[5.2]
  def change
    add_column :orderitems, :status, :boolean, default: false
  end
end
