# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer
#

class Asset < ActiveRecord::Base
  belongs_to :product, :inverse_of => :assets

  validates :product, :presence => true

  has_attached_file :image, :styles => { :thumbnail => "100x100!" }
  attr_accessible :image
end
