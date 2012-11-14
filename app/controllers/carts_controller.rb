class CartsController < ApplicationController

  def show

  end

  def new

  end

  def create
    id = params[:id].to_i
    @product = Product.find(id)
    session[:cart] ||= {}

    count = params[:count].to_i || 1

    session[:cart][id] ||= 0
    session[:cart][id] += count

    render partial: 'products/cart', locals: { cart: get_cart }
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    
    render partial: 'products/cart', locals: { cart: get_cart }
  end

  def update
    id = params[:id].to_i
    count = params[:count].to_i
    if session[:cart][id]
      if count == 0
        session[:cart].delete(id)
      else
        session[:cart][id] = count
      end
      render partial: 'products/cart', locals: { cart: get_cart }
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
      products = Product.where("id IN (?)", ids)
      products.each do |product|
        result[product] = session[:cart][product.id]
      end
    end

    @cart = result
  end

end
