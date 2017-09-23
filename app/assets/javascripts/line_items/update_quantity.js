updateQuantity = function(lineItemId) {
  console.log('updateQuantity start');
  $("#update-line-item-" + lineItemId).click();
  console.log('updateQuantity finish!');
};

// $(document).on('turbolinks:load', updateQuantity = function(lineItemId) {
//   console.log('updateQuantity start');
//   $("#update-line-item-" + lineItemId).click();
//   console.log('updateQuantity finish!');
// });

// $(document).on("turbolinks:load", function() {
//   $("#new_article").on("ajax:success", (e, data, status, xhr) ->
//     $("#new_article").append xhr.responseText
//   ).on "ajax:error", (e, xhr, status, error) ->
//     $("#new_article").append "<p>ERROR</p>"
// });

// $.ajax({
//   url: "/line_items/" + lineItemId,
//   type: "PATCH",
//   success: function(result){
//       alert("Cool");
//       $(".hidden-xs").html("It works!");
//   }});
