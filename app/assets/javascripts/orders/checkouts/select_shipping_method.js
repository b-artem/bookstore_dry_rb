$(document).on('turbolinks:load', function() {
  $(".radio-label:visible").children('.radio-input').first().prop('checked', true);
});
