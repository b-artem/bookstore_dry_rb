$(document).on('turbolinks:load', function() {
  $('#star-rating').raty({
    path: '/assets',
    scoreName: 'review[score]'
  });
});
