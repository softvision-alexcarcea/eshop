class CartsController < ApplicationController

  def show

  end

  def new

  end

  def create
    @cart = Cart.new(session)
    @cart.add(params[:id], params[:count])

    render partial: 'products/cart', locals: { cart: @cart }
  end

  def destroy
    @cart = Cart.new(session)
    @cart.remove(params[:id])
    
    render partial: 'products/cart', locals: { cart: @cart }
  end

  def update
    @cart = Cart.new(session)
    @cart.update(params[:id], params[:count])
    
    render partial: 'products/cart', locals: { cart: @cart }
  end
end
