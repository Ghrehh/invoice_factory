var ready = function() {
  
  $(".line-button").click(function(){
    var serviceContent = $(".service").val();
    var descriptionContent = $(".description").val();
    var priceContent = $(".price").val();
    
    $(".line-container").append("<div class='line'><p class='service-paragraph'>" + serviceContent + ":</p> <p class='description-paragraph'> " + descriptionContent + "</p> <p class='price-paragraph'>||£" + priceContent + "</p>||</div>" );
    
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
