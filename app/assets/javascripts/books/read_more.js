$(document).on('turbolinks:load', function() {
  $("#read-more").click(function(event) {
    var full_description = $('#full_description').val();
    event.preventDefault();
    $(this).parent().html(full_description);
  });
});
