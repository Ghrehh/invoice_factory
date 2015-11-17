var last_click = 0

function topDrop() {
  

  $("#file-icon").click(function(){
    console.log("test");
    if ( $(".dropdown-invoices-container").is(":visible") && last_click < Date.now() ) {
      $(".dropdown-invoices-container").hide();
      $(this).css({color: "#1c1c1c"})
      last_click = Date.now() + 300;
    }
    else if( last_click < Date.now()) {
      $(".dropdown-invoices-container").show();
      $(this).css({color: "white"}) //keeps the color as white when the menu is showing
      last_click = Date.now() + 300;
    }
    
  })
  
}