class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :name
      t.string :email
      t.string :address
      t.integer :cc_num
      t.string :cc_exp
      t.integer :cc_cvv
      t.integer :billing_zip

      t.timestamps
    end
  end
end
