incrementQuantity = function() {
  var quantity;
  quantity = $(event.target).parent().siblings('.quantity-input').val();
  quantity++;
  $(event.target).parent().siblings('.quantity-input').val(quantity);
};
