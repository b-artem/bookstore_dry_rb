$(document).ready(function($) {
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
