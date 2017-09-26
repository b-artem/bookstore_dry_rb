$(document).on('turbolinks:load', function() {
  var checked = $('#use_billing_address').data('checked');
  $('#use_billing_address').prop('checked', checked);
  $('#shipping-address-form').prop('hidden', checked);

  $("#use_billing_address").change(function() {
    var checked = $(this).prop('checked')
    $('#shipping-address-form').prop('hidden', checked);
  });
  console.log('use_billing_address');
});
