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
  attr_accessible :description, :name, :price, :assets, :assets_attributes

  validates :name,  :presence   => true,
                    :length     => { :within => 3..100 },
                    :uniqueness => true

  has_many :assets, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true
end
