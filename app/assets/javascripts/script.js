var ready = function() {
  
  $(".line-button").click(function(){

    setTimeout(function(){ //timeout because without it the form cleared to fast and a empty form was submitted
      $(".service").val("");
      $(".description").val("");
      $(".price").val("");
      $(".service").focus();
    }, 100);
    
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
