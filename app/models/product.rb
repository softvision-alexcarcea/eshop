# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :float
#

class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price

  validates :name, :presence => true
end
