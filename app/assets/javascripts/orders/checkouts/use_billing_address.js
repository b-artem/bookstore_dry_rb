$(document).on('turbolinks:load', function() {
  var checked = $('#use_billing_address').data('checked');
  $('#use_billing_address').prop('checked', checked);
  $('#shipping-address-form').prop('hidden', checked);

  $("#use_billing_address").change(function() {
    var checked = $(this).prop('checked')
    $('#shipping-address-form').prop('hidden', checked);
  });

});




//
// $(document).on('turbolinks:load', function() {
//   var checked = $('#use_billing_address').data('checked');
//   if ( checked == true ) {
//     $('#use_billing_address').prop('checked', true);
//     $('#shipping-address-form').prop('hidden', true);
//   } else {
//     $('#use_billing_address').prop('checked', false);
//     $('#shipping-address-form').prop('hidden', false);
//   }
//
//   $("#use_billing_address").change(function() {
//      if ( $(this).prop('checked') ) {
//        $('#shipping-address-form').prop('hidden', true);
//      } else {
//        $('#shipping-address-form').prop('hidden', false);
//      }
//   });
//
// });
