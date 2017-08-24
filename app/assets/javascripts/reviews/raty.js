// $(function($) {
//   console.log('start');
//   $('.star-rating').raty({
//     path: '/assets/',
//     readOnly: true,
//     score: function() {
//       return $(this).attr('data-score');
//     }
//   });
//   console.log('end');
// });

// $.noConflict();

// $(document).on('turbolinks:load', function($) {
$(document).ready(function($) {
  console.log('start');
  $('.star-rating').raty({
    path: '/assets/',
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });
  console.log('two');

  $('#star-rating').raty({
    path: '/assets',
    scoreName: 'review[score]'
  });
  console.log('end!');
});



// $(document).ready(myF);
//
// function myF() {
//   console.log('start');
//   $('.star-rating').raty({
//     path: '/assets/',
//     readOnly: true,
//     score: function() {
//           return $(this).attr('data-score');
//   }
//   });
//   // console.log('end');
//   $('.star-rating').html('HHHHHHHH');
// }
