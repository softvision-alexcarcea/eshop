function add_asset(element) {
  var asset = "<input type=\"file\" name=\"product[asset_files][]\"/><br/>";
  element.before(asset);
  count++;
}

function remove_asset(element) {
  var id = /\d+/.exec(element.attr("id"));
  $("#product_assets_attributes_" + id + "__destroy").val(true);
  element.prev("li").hide("slow");
}

$(document).ready(function() {
  $(".add-image").click(function(event) {
    event.preventDefault();
    return add_asset($(this));
  });
  $(".remove-image").click(function(event) {
    event.preventDefault();
    return remove_asset($(this));
  });
});
