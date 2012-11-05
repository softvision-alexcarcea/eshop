class PagesController < ApplicationController
  def index
    @title = "Home Page"
    @root = true
    @products = Product.all
  end
end
