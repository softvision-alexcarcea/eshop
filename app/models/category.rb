class Category < ActiveRecord::Base
  attr_accessible :name, :description, :products
  
  has_and_belongs_to_many :products
  has_ancestry
end
