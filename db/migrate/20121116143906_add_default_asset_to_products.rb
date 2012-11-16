class AddDefaultAssetToProducts < ActiveRecord::Migration
  def change
    add_column :products, :default_asset_id, :integer
  end
end
