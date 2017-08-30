editQuantity = function(lineItemId) {
  console.log('editQuantity start');
  // $("#form-line-item-" + lineItemId).ajaxSuccess(function() {
  $(document).on('ajaxSuccess', "#form-line-item-" + lineItemId, function(){
    // $(".log").text( "Triggered ajaxSuccess handler." );
    $("#input-line-item-" + lineItemId).val("skdfjgh");
  });
  $("#form-line-item-" + lineItemId).submit();
  console.log('editQuantity finish!');

};

// $(document).on("turbolinks:load", function() {
//   $("#new_article").on("ajax:success", (e, data, status, xhr) ->
//     $("#new_article").append xhr.responseText
//   ).on "ajax:error", (e, xhr, status, error) ->
//     $("#new_article").append "<p>ERROR</p>"
//
// });






// var input = document.getElementById('test');
// input._value = input.value;
// Object.defineProperty(input, "value", {
//     get: function() {return this._value;},
//     set: function(v) {
//         // Do your stuff
//         this._value = v;
//     }
// });



//
// $("<%= escape_javascript(render @lineitem) %>").appendTo("#users");
// $("<%= escape_javascript(render @user) %>").appendTo("#users");
//
//
//
// $.ajax({
//   url: "/line_items/" + lineItemId,
//   type: "PATCH",
//   success: function(result){
//       alert("Cool");
//       $(".hidden-xs").html("It works!");
//   }});
