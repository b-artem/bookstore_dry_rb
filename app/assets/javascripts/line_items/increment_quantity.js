$(document).on('turbolinks:load', function() {
  $('.quantity-input-plus').click(function() {
    event.preventDefault();
    var input = $(event.target).parent().siblings('.quantity-input');
    var quantity = input.val();
    quantity++;
    input.val(quantity);
    input.trigger("change");
  });
});
