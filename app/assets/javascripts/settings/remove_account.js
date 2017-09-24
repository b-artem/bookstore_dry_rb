$(document).on('turbolinks:load', function() {
  $("#remove-account-cb").change(function() {
    if ( $(this).prop('checked') == true ) {
      $("#remove-account-btn").removeClass('disabled');
      $("#remove-account-btn").prop('disabled', false);
    } else {
      $("#remove-account-btn").addClass('disabled');
      $("#remove-account-btn").prop('disabled', true);
    }
  });
});
