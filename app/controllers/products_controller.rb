class ProductsController < ApplicationController
  before_filter :authenticate_admin!,
                :only => [:new, :create, :edit, :update, :destroy]

  before_filter :initialize_cart, only: [:index, :show, :search]
  
  load_and_authorize_resource except: [:create, :search]

  def index
    @products = @products.page(params[:page]).per(@products_per_page)
    @search = Product.search(params[:q])
    @categories = Category.arrange(:order => :name)
    @title = "Product list"
    @root = true
  end

  def new
    @categories = Category.order(:name)
    @title = "Create product"
  end

  def create
    @product = Product.new(product_params)
    authorize! :create, @product
    if @product.save
      redirect_to root_path, flash: { success: "Product successfully created" }
    else
      flash.now[:error] = "Could not create product"
      render :new
    end
  end

  def edit
    @categories = Category.order(:name)
    @title = "Edit #{@product.name}"
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to root_path, :flash => { :success => "Product successfully updated" }
    else
      flash.now[:error] = "Could not update product"
      render :edit
    end
  end

  def show
    @categories = Category.arrange(:order => :name)
    @title = @product.name
  end

  def destroy
    flash = if @product.destroy
              { :success => "Product successfully deleted" }
            else
              { :error => "Could not delete product" }
            end

    redirect_to products_path, flash: flash
  end

  def search
    authorize! :read, Category
    @category = (params[:category_id]) ?
      Category.find(params[:category_id]) : nil
    source = @category ? @category.products : Product

    @search = source.search(search_params)
    @products = @search.result

    @products = @products.tagged_with(params[:tags]) unless params[:tags].blank?

    @products_per_page = params[:limit].to_i unless params[:limit].blank?

    @products = @products.page(params[:page]).per(@products_per_page)

    @categories = Category.arrange(:order => :name)
    @title = "Search results"

    render :index
  end
  
  private
    def product_params
      params.require(:product).permit(
          :name, :description, :price, :category_ids,
          :tag_list, :default_asset_id, :asset_files,
          :assets_attributes
        )
    end
    
    def search_params
      params.require(:q).permit(
          :name_or_description_cont, :price_lteq, :price_gteq, :s
        )
    end
end
