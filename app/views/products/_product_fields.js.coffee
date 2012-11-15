add_asset = (element) ->
  asset = "<input type=\"file\" name=\"product[asset_files][]\"/><br/>"
  element.before(asset)

remove_asset = (element) ->
  id = element.attr("data-id")
  destroy = $("#product_assets_attributes_#{id}__destroy")
  img = element.prev().prev().children()
  if element.text() == "Remove"
    img.fadeTo("slow", 0.5)
    element.text("Undo")
    destroy.val(true)
  else
    img.fadeTo("slow", 1)
    element.text("Remove")
    destroy.val(false)

$(document).ready( ->
  $(".add-image").click( (event) ->
    event.preventDefault()
    return add_asset($(this))
  )
  
  $(".remove-image").click( (event) ->
    event.preventDefault()
    return remove_asset($(this))
  )
)
