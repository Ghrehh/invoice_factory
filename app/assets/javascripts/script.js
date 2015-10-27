set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.sortable > li').each(function(i){ 
      $(this).attr("data-pos",i+1);
  });
};

set_positions2 = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.sortable2 > li').each(function(i){ 
      $(this).attr("data-pos",i+1);
  });
};


var hideDiv = function(div) {
  $(div + " > div").animate({ marginLeft: '-1000px' }, 200);
  $(div).animate({ width: '0px' }, 200, function() {
     
      $(this).hide();
      $('.left-tab').show();
      $('.right-tab').hide();

  });
};

var showDiv = function(div) {
  $(div).animate({ width: '650px' }, 200, function() {
    
      

      $(div + " > div").animate({ marginLeft: '20px' }, 200);
      $(this).show();
    });
};

var hideDivLeft = function(div) {
  
  $(div + " > div").animate({ marginLeft: '1000px' }, 200);
  $(div).animate({ width: '0px', margin: '0px' }, 200, function() {
     
      $(this).hide();
  });
  
};



var showDivLeft = function(div) {
  $('.left-tab').hide()
  $(div).show();
  $(div).animate({ width: '300px' }, 200, function() {
    
      $(div + " > div").animate({ marginLeft: '15px' }, 200,function(){
         $(".right-tab").show();
      });
      
    });
};






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


  set_positions();
  
  
  $('.sortable').sortable().bind('sortupdate', function() {
    
    
    updated_order = [];
    // set the updated positions
    set_positions();

    // populate the updated_order array with the new task positions
    $('.sortable > li').each(function(i){
        updated_order.push($(this).data("id"));
    });
    
    //console.log(updated_order)
    
    $.ajax({
        type: "PUT",
        url: '/lines/order',
        data: { order: updated_order }
      
    });
    
  });
  
  set_positions2();
  
 $('.sortable2').sortable().bind('sortupdate', function() {
    
    
    updated_order = [];
    // set the updated positions
    set_positions2();

    // populate the updated_order array with the new task positions
    $('.sortable2 > li').each(function(i){
        updated_order.push($(this).data("id"));
    });
    
    //console.log(updated_order)
    console.log(updated_order)
    $.ajax({
        type: "PUT",
        url: '/toplines/order',
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
  

  
  $(".date-form-dashboard").datepicker({ dateFormat: 'dd-mm-yy' }).val()
  
  var wait_period = true
  
  $(".left-tab").click(function(){
    
    if (wait_period == true) {
      $(this).hide();
      showDivLeft(".dashboard-left-container");
      hideDivLeft(".iframe-container");
      wait_period = false
      
      setTimeout(function(){
        wait_period = true;
      }, 2000);
    }
  });
  
  $(".right-tab").click(function(){
    
    if (wait_period == true) {
      $(this).hide();
      hideDiv(".dashboard-left-container");
      showDiv(".iframe-container");
      wait_period = false;
      
    
      setTimeout(function(){
        wait_period = true;
      }, 2000);
    }
  });
 
  //autosize($('.address-form-dashboard'));
  var user_drop_shown = false
  $(".fa-user").click(function(){
    if (user_drop_shown == false){
      $(".user-dropdown").show();
      user_drop_shown = true
    }
    else {
      $(".user-dropdown").hide();
      user_drop_shown = false
    }
  })

};

$(document).ready(ready);
$(document).on('page:load', ready);
