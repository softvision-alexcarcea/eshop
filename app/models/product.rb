# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :float            default(0.0)
#

class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :tag_list,
                  :assets, :assets_attributes,
                  :categories, :category_ids, :asset_files

  validates :name,  :presence   => true,
                    :length     => { :within => 3..100 },
                    :uniqueness => true

  has_many :assets, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true
  
  has_and_belongs_to_many :categories
  
  acts_as_taggable
  
  def asset_files=(files)
    files.each do |asset|
      assets.create(image: asset)
    end
  end
end
