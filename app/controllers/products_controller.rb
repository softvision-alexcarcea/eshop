class ProductsController < ApplicationController
  def create
  end

  def new
  end

  def edit
  end

  def destroy
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.name
  end

  def index
    @title = "Products list"
    @products = Product.all
  end
end
