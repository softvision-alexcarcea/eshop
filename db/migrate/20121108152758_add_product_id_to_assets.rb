class AddProductIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :product_id, :integer
    add_index :assets, :product_id
  end
end
