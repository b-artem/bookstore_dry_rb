$(document).on('turbolinks:load', function() {
  $("#state-filter li a").click(function() {
    // $("#filter-btn").html($(this).text() + ' <span class="caret"></span>');
    // $("#filter-btn").val($(this).data('value'));
    var t = ($(this).text());
    setTimeout(function(){ $("span#text").text(t); }, 300);
    // $("#filter-btn").text($(this).text());
    // $("#filter-btn").val($(this).text());

 });
});

// $(document).ready(function() {
//   $("#state-filter li a").click(function() {
//     // $("#filter-btn").html($(this).text() + ' <span class="caret"></span>');
//     // $("#filter-btn").val($(this).data('value'));
//     var t = ($(this).text());
//     setTimeout(function(){ $("span#text").text(t); }, 300);
//     // $("#filter-btn").text($(this).text());
//     // $("#filter-btn").val($(this).text());
//
//  });
// });
