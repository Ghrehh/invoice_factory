function tutorial(){
  
  $(".tutorial-button").click(function(){
    
    setTimeout(function(){
      
      if ($(".tutorial-form").val() == "") {
        $(".tutorial-error").animate({opacity:"1"});
      }
      else if ($(".tutorial-1-confirm").html() == "true") {
        $(".tutorial-button").animate({width: "40px", 
                        backgroundColor: "#87D687", 
                        "border-top-color": "#9EF19E", 
                        "border-left-color": "#9EF19E",
                        "border-bottom-color": "#78B978",
                        "border-right-color": "#78B978"
        }, 200);
        $(".tutorial-button").html("✔");
        button_state = "success"
        $(".tutorial-error").hide();
        
        setTimeout(function(){
          $(".tutorial-inner-1").animate({opacity:"0"}, 500, function(){
            $(this).animate({height: "0px"});
            $(".tutorial-container").animate({width:"500px", height:"280px", backgroundColor: "#7FAE74"});
            $(".tutorial-container-container").animate({width:"500px"});
            $(".circle-container").animate({backgroundColor: "#6E9864"},function(){
              $(".circle-1").animate({backgroundColor: "#272727"}, 200);
              
              $(".circle-2").animate({backgroundColor: "#FDFF8E"}, 200, function(){
                $(".tutorial-inner-1").hide();
                $(".tutorial-inner-2").fadeIn();
                $(".tutorial-container").animate({marginLeft:"265px"}, function(){
                  $(".iframe-container").css({visibility:"visible"});
                  $(".iframe-container").animate({opacity:"1"});
                  
                  $(".tutorial-toplines-container").fadeIn();
                });
              });
              
            });
          });
        }, 500);
        
      }
      
    }, 500);
    
  });
  
  $(".tutorial-button").hover(function() {
    if (button_state == "success") {
      $(".tutorial-button").css({backgroundColor: "#5e965e"});
    }
  }, function() {
    if (button_state == "success") {
      $(".tutorial-button").css({backgroundColor: "#87D687"});
    }
  });
  
}
