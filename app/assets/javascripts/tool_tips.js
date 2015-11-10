var tool_tips = function() {
  
  $("#group-icon").hover(function(){ //tooltip group top
    $("#group-paragraph-container").animate({ width: '130px' }, 50, function() {
      $("#group-paragraph").fadeIn( 50 );
    });
  }, function(){
    $("#group-paragraph").fadeOut(50, function( ){
    $("#group-paragraph-container").animate({ width: '0px' }, 50);
    });
  })
  
  $("#invoice-icon").hover(function(){ //tooltip group top
    $("#invoice-paragraph-container").animate({ width: '120px' }, 50, function() {
      $("#invoice-paragraph").fadeIn(50);
    });
  }, function(){
    $("#invoice-paragraph").fadeOut(50, function(){
    $("#invoice-paragraph-container").animate({ width: '0px' }, 50);
    });
  })
  
  $("#edit-icon").hover(function(){ //tooltip group top
    $("#edit-paragraph-container").animate({ width: '130px' }, 50, function() {
      $("#edit-paragraph").fadeIn(50);
    });
  }, function(){
    $("#edit-paragraph").fadeOut(50, function(){
    $("#edit-paragraph-container").animate({ width: '0px' }, 50);
    });
  })
  
};

