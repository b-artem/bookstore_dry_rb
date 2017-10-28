$(document).on('turbolinks:load', decrementQuantity = function() {
  $('.quantity-input-minus').click(function() {
    event.preventDefault();
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
});
