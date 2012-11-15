class CategoriesController < ApplicationController
  before_filter :authenticate_admin!,
                :only => [:new, :create, :edit, :update, :destroy]
  
  def new
    @category = Category.new(:parent_id => params[:parent_id])
    @title = "Create category"
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, :flash => { :success => "Category successfully created" }
    else
      flash.now[:error] = "Could not create category"
      render :new
    end
  end
  
  def index
    @categories = Category.arrange(:order => :name)
    @title = "Category list"
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.arrange(:order => :name)
    @products = @category.products.page(params[:page]).per(@products_per_page)
    @cart = Cart.new(session)
    @title = @category.name
  end

  def edit
    @category = Category.find(params[:id])
    @title = "Edit #{@category.name}"
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to categories_path, :flash => { :success => "Category successfully updated" }
    else
      flash.now[:error] = "Could not update category"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, :flash => { :success => "Category successfully deleted" }
    else
      redirect_to categories_path, :flash => { :error => "Could not delete category" }
    end
  end
end
