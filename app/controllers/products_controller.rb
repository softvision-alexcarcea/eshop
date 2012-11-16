class ProductsController < ApplicationController
  before_filter :authenticate_admin!,
                :only => [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(@products_per_page)
    @categories = Category.arrange(:order => :name)
    @cart = Cart.new(session)
    @title = "Product list"
    @root = true
  end

  def new
    @product = Product.new
    @categories = Category.order(:name)
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
    @categories = Category.order(:name)
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
    @cart = Cart.new(session)
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
  
  def search
    queries = []
    parameters = {}
    
    if(params[:query] && !params[:query].blank?)
      queries << "LOWER(name) LIKE :query OR LOWER(description) LIKE :query"
      parameters[:query] = "%#{params[:query]}%"
    end
    
    if(!params[:min_price].blank?)
      if(!params[:max_price].blank?)
        queries << "price BETWEEN :min_price AND :max_price"
        parameters[:min_price] = params[:min_price].to_i
        parameters[:max_price] = params[:max_price].to_i
      else
        queries << "price <= :min_price"
        parameters[:min_price] = params[:min_price].to_i
      end
    elsif(!params[:max_price].blank?)
      queries << "price >= :max_price"
      parameters[:max_price] = params[:max_price].to_i
    end
    
    source = params[:category_id] ?
      Category.find(params[:category_id]).products : Product
    
    @products = source.where(queries.join(" AND "), parameters)
    
    if(!params[:tags].blank?)
      @products = @products.tagged_with(params[:tags])
    end
    
    @products = @products.order(params[:order])
    
    if(!params[:limit].blank?)
      @products_per_page = params[:limit].to_i
    end
    
    @products = @products.page(params[:page]).per(@products_per_page)
    
    @categories = Category.arrange(:order => :name)
    @cart = Cart.new(session)
    @title = "Search results"
    
    render :index
  end
end
