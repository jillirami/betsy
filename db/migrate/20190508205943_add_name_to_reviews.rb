class AddNameToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :reviewer, :string
  end
end
