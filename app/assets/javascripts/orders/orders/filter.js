$(document).on('turbolinks:load', function() {
  $("#state-filter li a").click(function() {
    var text = ($(this).text());
    setTimeout(function() { $("span#text").text(text); }, 300);
    console.log('filter');
  });
});
