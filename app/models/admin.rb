class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable,
  # :registerable, :recoverable and :trackable
  devise :database_authenticatable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :remember_me, :password,
                  :password_confirmation
                  
  # attr_accessible :title, :body
end
