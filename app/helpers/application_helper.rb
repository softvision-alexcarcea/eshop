module ApplicationHelper
  def title
    @title ? "eShop - #{@title}" : "eShop"
  end
  
  def current_uri?(uri)
    uri == request.uri
  end
end
