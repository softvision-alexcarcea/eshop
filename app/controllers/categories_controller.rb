class CategoriesController < ApplicationController
  before_filter :authenticate_admin!,
                only: [:new, :create, :edit, :update, :destroy]

  before_filter :initialize_cart, only: :show
  
  load_and_authorize_resource only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new params.permit(:parent_id)
    authorize! :create, @category
    @title = "Create category"
  end

  def create
    @category = Category.new category_params
    authorize! :create, @category
    if @category.save
      redirect_to categories_path, :flash => { :success => "Category successfully created" }
    else
      flash.now[:error] = "Could not create category"
      render :new
    end
  end

  def index
    authorize! :read, Category
    @categories = Category.arrange(:order => :name)
    @title = "Category list"
  end

  def show
    @categories = Category.arrange(:order => :name)
    @search = Product.search(params[:q])
    @products = @category.products.page(params[:page]).per(@products_per_page)
    @title = @category.name
  end

  def edit
    @title = "Edit #{@category.name}"
  end

  def update
    if @category.update_attributes category_params
      redirect_to categories_path, :flash => { :success => "Category successfully updated" }
    else
      flash.now[:error] = "Could not update category"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, :flash => { :success => "Category successfully deleted" }
    else
      redirect_to categories_path, :flash => { :error => "Could not delete category" }
    end
  end

  private
    def category_params
      params.require(:category).
        permit(:name, :description, :products, :parent_id)
    end
end
