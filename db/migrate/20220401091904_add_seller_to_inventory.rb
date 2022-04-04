class AddSellerToInventory < ActiveRecord::Migration[6.1]
  def change
    add_reference :inventories, :seller, null: false, foreign_key: true
  end
end
