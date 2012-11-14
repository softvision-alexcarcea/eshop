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

    render partial: 'products/cart', locals: { cart: get_cart }
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
