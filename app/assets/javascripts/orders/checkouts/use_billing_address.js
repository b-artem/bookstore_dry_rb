$(document).on('turbolinks:load', function() {
  var checked = $('#use_billing_address').data('checked');
  if ( checked == true ) {
    $('#use_billing_address').prop('checked', true);
    $('#shipping-address-form').prop('hidden', true);
  } else {
    $('#use_billing_address').prop('checked', false);
    $('#shipping-address-form').prop('hidden', false);
  }
});

$("#use_billing_address").change( function(){
  alert('sfh0');
  //  if ( $(event.target).prop('checked') ) {
  //    alert("checked");
  //  } else {
  //    alert('no');
  //  }
});




//
// ready(function() {
//     //set initial state.
//     $('#textbox1').val($(this).is(':checked'));
//
//     $('#checkbox1').change(function() {
//         $('#textbox1').val($(this).is(':checked'));
//     });
//
//     $('#checkbox1').click(function() {
//         if (!$(this).is(':checked')) {
//             return confirm("Are you sure?");
//         }
//     });
// });
