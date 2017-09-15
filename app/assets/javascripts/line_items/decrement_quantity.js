$(document).on('turbolinks:load', decrementQuantity = function() {
  var input = $(event.target).parent().siblings('.quantity-input');
  quantity = input.val();
  if ( quantity <= '1' ) {
    input.val(1);
    return false;
  } else {
    quantity--;
  }
  input.val(quantity);
  input.trigger("change");
});


// decrementQuantity = function() {
//   var quantity;
//   quantity = $(event.target).parent().siblings('.quantity-input').val();
//   if ( quantity == '1' ) {
//     return false;
//   } else {
//     quantity--;
//   }
//   $(event.target).parent().siblings('.quantity-input').val(quantity);
// };
