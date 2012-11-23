module ProductsHelper
  def product_default_image_url(product, format = :original)
    asset = product.default_asset || product.assets.first
    asset ? asset.image.url(format) : "/assets/images/#{format}/missing.png"
  end
end
