$(document).on('turbolinks:load', incrementQuantity = function() {
  var input = $(event.target).parent().siblings('.quantity-input');
  var quantity = input.val();
  quantity++;
  input.val(quantity);
  input.trigger("change");
  console.log('increment_quantity');
});
