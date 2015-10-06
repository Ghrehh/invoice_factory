var ready = function() {
  
  $(".line-button").click(function(){
    var serviceContent = $(".service").val();
    var descriptionContent = $(".description").val();
    var priceContent = $(".price").val();
    
    $(".line-container").append(serviceContent + ": " + descriptionContent + " ||£" + priceContent + "||<br>" );
    
    setTimeout(function(){
      $(".service").val("");
      $(".description").val("");
      $(".price").val("");
    }, 100);
    
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
