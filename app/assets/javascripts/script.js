set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.sortable > li').each(function(i){ 
      $(this).attr("data-pos",i+1);
  });
};






var ready = function() {
  
  $(".line-button").click(function(){ //clears the form after it's been posted
 
     setTimeout(function(){ //timeout because without it the form cleared to fast and an empty form was submitted
       $(".service").val("");
       $(".description").val("");
       $(".price").val("");
       $(".service").focus();
     }, 100);
     
   });
   
   
   //FOR THE EDIT INV BUTTON
    var edit_inv_shown = false;
    
    $(".edit-inv").click(function(){
      
      if (edit_inv_shown == false) {
        $(".edit-inv-form").slideDown(200);
        edit_inv_shown = true;
      }
      else {
        $(".edit-inv-form").slideUp(200);
        edit_inv_shown = false;
      }
     
   });
   
   
   //FOR THE CUSTOM TOTAL BAR
    var custom_total_shown = false;
    
    $(".custom-total").click(function(){
      
      if (custom_total_shown == false) {
        $(".custom-total-container").slideDown(200);
        custom_total_shown = true;
      }
      else {
        $(".custom-total-container").slideUp(200);
        custom_total_shown = false;
      }
     
   });


  set_positions();
  
  
  $('.sortable').sortable().bind('sortupdate', function() {
    
    
    updated_order = [];
    // set the updated positions
    set_positions();

    // populate the updated_order array with the new task positions
    $('.sortable > li').each(function(i){
        updated_order.push($(this).data("id"));
    });
    
    //console.log(updated_order)
    
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
  
  var add_arr = []
  var datadump = ($('#trackers').data('trackers'));
  
  find_address = function(recipient){
    datadump.forEach(function(x){
      if(x[0] == recipient.value){
        add_arr = x
        return;
      }
    });
  };
  
  
  if (datadump != null ) { //will only run the suggestion thing if it recieves the data, as it breaks otherwise D:
  
  
      var my_Suggestion_class = new Bloodhound({
                          limit: 10,
                          datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                          queryTokenizer: Bloodhound.tokenizers.whitespace,
                          local: $.map(datadump, function(item) {
                              //console.log(item);
                              return {value: item[0]};
                          })
                      });
      
              //Initialize the Suggestion Engine
                      my_Suggestion_class.initialize();
      
                      
                      $(".recipient-form").typeahead({
                          hint: true,
                          highlight: true,
                          minLength: 1
                      },
                      {
                          name: 'value',
                          displayKey: 'value',
                          source: my_Suggestion_class.ttAdapter()
                      });


  }
  
  $('.recipient-form').on('typeahead:selected', function(evt, item) {
      console.log(item)
      find_address(item)
      console.log(add_arr)
      $(".add1").val(add_arr[1]);
      $(".add2").val(add_arr[2]);
      $(".add3").val(add_arr[3]);

  })
    

};

$(document).ready(ready);
$(document).on('page:load', ready);
