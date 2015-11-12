function tutorial(){
  
  $(".tutorial-button").click(function(){
    $(this).animate({width: "105px", 
                    backgroundColor: "#87D687", 
                    "border-top-color": "#9EF19E", 
                    "border-left-color": "#9EF19E",
                    "border-bottom-color": "#78B978",
                    "border-right-color": "#78B978"
    }, 200);
    $(this).val("✔ Continue");
    button_state = "success"
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
