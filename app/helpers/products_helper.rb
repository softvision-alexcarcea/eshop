module ProductsHelper
  def product_default_image_url(product, format = :original)
    product.assets.any? ? product.assets[0].image.url(format) : "/system/assets/images/#{format}/missing.png"
  end
end
