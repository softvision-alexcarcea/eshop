class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def initialize_cart
    @cart = Cart.new session
  end
end
