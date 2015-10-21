set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.sortable > li').each(function(i){ 
      $(this).attr("data-pos",i+1);
  });
}

var ready = function() {
  
  $(".line-button").click(function(){ //clears the form after it's been posted
 
     setTimeout(function(){ //timeout because without it the form cleared to fast and an empty form was submitted
       $(".service").val("");
       $(".description").val("");
       $(".price").val("");
       $(".service").focus();
     }, 100);
     
   });
   
   
   //FOR THE EDIT INV BUTTON
    var edit_inv_shown = false;
    
    $(".edit-inv").click(function(){
      
      if (edit_inv_shown == false) {
        $(".edit-inv-form").slideDown(200);
        edit_inv_shown = true;
      }
      else {
        $(".edit-inv-form").slideUp(200);
        edit_inv_shown = false;
      }
     
   });
   
   
   //FOR THE CUSTOM TOTAL BAR
    var custom_total_shown = false;
    
    $(".custom-total").click(function(){
      
      if (custom_total_shown == false) {
        $(".custom-total-container").slideDown(200);
        custom_total_shown = true;
      }
      else {
        $(".custom-total-container").slideUp(200);
        custom_total_shown = false;
      }
     
   });
   
   var plus_square_shown = false
   $(".fa-plus-square").click(function(){
     if (plus_square_shown == false){
      $(".dashboard-right").slideDown()
      plus_square_shown = true
     }
     else {
       $(".dashboard-right").slideUp()
       plus_square_shown = false
     }
   })
   
  

  set_positions()
  
  
  $('.sortable').sortable().bind('sortupdate', function() {
    
    
    updated_order = [] 
    // set the updated positions
    set_positions();

    // populate the updated_order array with the new task positions
    $('.sortable > li').each(function(i){
        updated_order.push($(this).data("id"));
    });
    
    console.log(updated_order)
    
    $.ajax({
        type: "PUT",
        url: '/lines/order',
        data: { order: updated_order }
    });
    
  });
  
  var mode = 0;
  
  $(".change-mode").click(function(){
    if (mode == 0){
      mode = 1;
      $(".line-mode").hide();
      $(".block-mode").show();
    }
    else {
      mode = 0;
      $(".line-mode").show();
      $(".block-mode").hide();
    }
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
