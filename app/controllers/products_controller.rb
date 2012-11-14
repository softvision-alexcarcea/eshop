class ProductsController < ApplicationController
  before_filter :authenticate_admin!,
                :only => [:new, :create, :edit, :update, :destroy]
  before_filter :get_cart,
                :only => [:index, :show]

  def index
    @products = Product.page(params[:page]).per(@products_per_page)
    @categories = Category.arrange(:order => :name)
    @title = "Product list"
    @root = true
  end

  def new
    @product = Product.new
    @categories = Category.all.order(:name)
    @title = "Create product"
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to root_path, :flash => { :success => "Product successfully created" }
    else
      flash.now[:error] = "Could not create product"
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
    @title = "Edit #{@product.name}"
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to root_path, :flash => { :success => "Product successfully updated" }
    else
      flash.now[:error] = "Could not update product"
      render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
    @categories = Category.arrange(:order => :name)
    @title = @product.name
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to products_path, :flash => { :success => "Product successfully deleted" }
    else
      redirect_to products_path, :flash => { :error => "Could not delete product" }
    end
  end

  private

    def get_cart
      result = nil

      if session[:cart] and session[:cart].any?
        result = {}
        ids = session[:cart].map { |id, count| id }
        # raise ids.inspect
        products = Product.where("id IN (?)", ids)
        products.each do |product|
          result[product] = session[:cart][product.id]
        end
      end

      @cart = result
    end
end
