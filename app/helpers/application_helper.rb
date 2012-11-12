module ApplicationHelper
  def title
    @title ? "eShop - #{@title}" : "eShop"
  end
  
  @products_per_page = 25
end
