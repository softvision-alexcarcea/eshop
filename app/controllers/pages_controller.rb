class PagesController < ApplicationController
  def index
    @title = "Home Page"
    @root = true
    @products = Product.page(params[:page]).per(@products_per_page)
  end
end
