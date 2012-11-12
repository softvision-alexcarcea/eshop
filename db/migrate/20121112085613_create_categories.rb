class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.string :ancestry
      t.timestamps
    end
    
    add_index :categories, :ancestry
    
    create_table :categories_products, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end
    
    add_index :categories_products, :category_id
    add_index :categories_products, :product_id
  end
end
