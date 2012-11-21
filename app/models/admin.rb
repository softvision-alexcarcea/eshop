# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  email               :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  role                :integer
#

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable,
  # :registerable, :recoverable and :trackable
  devise :database_authenticatable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :password,
                  :password_confirmation, :role
  
  ROLE_SUPER = 1
  ROLE_MODERATOR = 2
  ROLE_EDITOR = 3
  
  def super?
    role == ROLE_SUPER
  end
  
  def moderator?
    role == ROLE_MODERATOR
  end
  
  def editor?
    role == ROLE_EDITOR
  end
end
