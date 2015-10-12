set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.sortable > li').each(function(i){
      $(this).attr("data-pos",i+1);
  });
}

var ready = function() {
  

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
