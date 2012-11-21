class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # enforce authorization checking
  check_authorization
  
  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  protected
  def initialize_cart
    @cart = Cart.new session
  end
end
