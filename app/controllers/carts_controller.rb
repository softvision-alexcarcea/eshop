class CartsController < ApplicationController

  def show

  end

  def new

  end

  def create
    id = params[:id].to_i
    @product = Product.find(id)
    session[:cart] ||= {}

    count = params[:count] || 1

    session[:cart][id] ||= 0
    session[:cart][id] += count.to_i

    render json: @product
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    render nothing: true
  end

  def update
    id = params[:id].to_i
    if params[:cart][id]
      if params[:count].to_i == 0
        session[:cart].delete(id)
      else
        session[:cart] = params[:count]
      end
      render nothing: true
    else
      raise 'Cart item not found'
    end
  end

end
