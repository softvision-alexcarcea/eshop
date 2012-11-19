class CartsController < ApplicationController
  before_filter :initialize_cart

  def show

  end

  def new

  end

  def create
    @cart.add params.require(:id), params.require(:count)

    render partial: 'products/cart', locals: { cart: @cart }
  end

  def destroy
    @cart.remove params.require(:id)

    render partial: 'products/cart', locals: { cart: @cart }
  end

  def update
    @cart.update params.require(:id), params.require(:count)

    render partial: 'products/cart', locals: { cart: @cart }
  end
end
