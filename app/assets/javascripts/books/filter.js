$(document).on('turbolinks:load', function() {
  $("#sort-by li a").click(function() {
    console.log('filter');
    var text = ($(this).text());
    setTimeout(function() { $("span#text").text(text); }, 500);
  });

  $("#sort-by-xs li a").click(function() {
    var text = ($(this).text());
    setTimeout(function() { $("span#text-xs").text(text); }, 500);
  });
});
