var tool_tips = function() {
  
  $("#group-icon").hover(function(){ //tooltip group top
    $("#group-paragraph-container").animate({ width: '130px' }, 100, function() {
      $("#group-paragraph").fadeIn( 100 );
    });
  }, function(){
    $("#group-paragraph").fadeOut(100, function( ){
    $("#group-paragraph-container").animate({ width: '0px' }, 100);
    });
  })
  
  $("#invoice-icon").hover(function(){ //tooltip group top
    $("#invoice-paragraph-container").animate({ width: '120px' }, 100, function() {
      $("#invoice-paragraph").fadeIn(100);
    });
  }, function(){
    $("#invoice-paragraph").fadeOut(100, function(){
    $("#invoice-paragraph-container").animate({ width: '0px' }, 100);
    });
  })
  
  $("#edit-icon").hover(function(){ //tooltip group top
    $("#edit-paragraph-container").animate({ width: '130px' }, 100, function() {
      $("#edit-paragraph").fadeIn(100);
    });
  }, function(){
    $("#edit-paragraph").fadeOut(100, function(){
    $("#edit-paragraph-container").animate({ width: '0px' }, 100);
    });
  })
  
};

