class Cart

  attr_accessor :session

  def initialize(session)
    self.session = session
    session[:cart] ||= {}
  end

  def products
    @products ||=
      session[:cart].none? ? [] :
        Product.where("id IN (?)", session[:cart].map { |id, count| id })
  end

  def count(product)
    session[:cart][product.id] || 0
  end

  def add(product, count = 1)
    id = product.is_a?(Product) ? product.id : product.to_i
    session[:cart][id] ||= 0
    session[:cart][id] += count.to_i
  end

  def update(product, count)
    id = product.is_a?(Product) ? product.id : product.to_i
    if session[:cart].has_key?(id)
      count = count.to_i
      if count == 0
        session[:cart].delete(id)
      else
        session[:cart][id] = count
      end
    else
      raise "Product not found in cart."
    end
  end

  def remove(product)
    id = product.is_a?(Product) ? product.id : product.to_i
    session[:cart].delete(id)
  end

end
