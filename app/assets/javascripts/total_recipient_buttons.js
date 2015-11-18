function totalRecipientButtons (){

  $(".recipient-button-edit").click(function(){
    $(this).hide();
    $(".right-inner-form").css({display:"inline-block"});
  });
  
  $(".total-button-edit").click(function(){
    $(this).hide();
    $(".right-inner-two-form").css({display:"inline-block"});
  });

};