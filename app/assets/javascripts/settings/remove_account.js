$(document).on('turbolinks:load', function() {
  $("#remove-account-cb").change(function() {
    $("#remove-account-btn").prop('disabled', !$("#remove-account-btn").prop('disabled'));
    $("#remove-account-btn").toggleClass('disabled');
  });
});
