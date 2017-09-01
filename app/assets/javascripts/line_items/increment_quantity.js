$(document).on('turbolinks:load', incrementQuantity = function() {
  var input = $(event.target).parent().siblings('.quantity-input');
  var quantity = input.val();
  quantity++;
  input.val(quantity);
  input.trigger("change");
});


// incrementQuantity = function() {
//   var quantity;
//   quantity = $(event.target).parent().siblings('.quantity-input').val();
//   quantity++;
//   $(event.target).parent().siblings('.quantity-input').val(quantity);
// };
