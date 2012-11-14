# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$( ->
  $("#cart-contents").on "ajax:success", "a.delete", (event, data) ->
    $("#cart-contents").html(data)

  $("#add-to-cart").on "ajax:success", (event, data) ->
    $("#cart-contents").html(data)
)
