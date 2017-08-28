decrementQuantity = function() {
  var quantity;
  quantity = $(event.target).parent().siblings('.quantity-input').val();
  if ( quantity == '1' ) {
    return false;
  } else {
    quantity--;
  }
  $(event.target).parent().siblings('.quantity-input').val(quantity);
};
