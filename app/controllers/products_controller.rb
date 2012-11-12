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

  # add product to cart
  def add
    id = params[:id].to_i
    @product = Product.find(id)
    if not session[:cart]
      session[:cart] = {}
    end
    
    count = params[:count] ? params[:count].to_i : 1
    if session[:cart][id]
      session[:cart][id] += count
    else
      session[:cart][id] = count
    end
    # raise session[:cart].inspect
    flash[:info] = "Product added to cart"
    redirect_to products_path
  end

  # remove product from cart
  def remove
    id = params[:id].to_i
    @product = Product.find(id)
    if session[:cart] and session[:cart][id]
      current_count = session[:cart][id]
      count = params[:count] ? params[:count].to_i : current_count
      if current_count > count
        # remove count units
        session[:cart][id] -= count
      else
        # remove all units
        session[:cart].delete(id)
      end
    end
    # raise session[:cart].inspect
    flash[:info] = "Product removed from cart"
    redirect_to products_path
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
