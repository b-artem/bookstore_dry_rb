// updateQuantity = function(lineItemId) {
//   $("#update-line-item-" + lineItemId).click();
// };

$(document).on('turbolinks:load', function() {
  $(".quantity-input").change(function() {
    // event.preventDefault();
    $(this).parent().children('button:hidden').click();
    // $(this).val('kjdshbfkjvgkdsh');
  });
});
