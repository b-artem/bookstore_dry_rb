$(document).on('turbolinks:load', function() {
  $(".quantity-input").change(function() {
    $(this).parent().children("input[type='submit']").click();
  });
});
