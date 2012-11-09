# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready () ->
  $(".add-image").click (event) ->
    event.preventDefault()
    add_asset $(this)
    
  $(".remove-image").click (event) ->
    event.preventDefault()
    remove_asset $(this)

add_asset = (element) ->
  asset = "<input type=\"file\" name=\"product[assets_attributes][#{count}][image]\" id=\"product_assets_attributes_#{count}_image\"/><br/>"
  element.before(asset)
  count++

remove_asset = (element) ->
  id = /\d+/.exec(element.attr "id")
  $("#product_assets_attributes_#{id}__destroy").val(true)
  element.parent().parent().hide("slow")
