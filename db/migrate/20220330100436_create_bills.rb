class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.references :product, array: true, default: []
      t.integer :quantity, array: true, default: []
      t.integer :price, array: true, default: []
      t.integer :total

      t.timestamps
    end
  end
end
