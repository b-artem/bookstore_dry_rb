$(document).on('turbolinks:load', function() {
  $("#state-filter li a").click(function() {
    var t = ($(this).text());
    setTimeout(function(){ $("span#text").text(t); }, 300);
 });
});
