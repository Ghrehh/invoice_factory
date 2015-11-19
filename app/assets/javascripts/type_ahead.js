var typeAhead = function() {

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
      
                      
                      $(".recipient-form-dashboard-new").typeahead({
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
  
  $('.recipient-form-dashboard-new').on('typeahead:selected', function(evt, item) {
      console.log(item);
      find_address(item);
      console.log(add_arr);
      $(".address-form-dashboard-new").val(add_arr[1]);
   

  });
  
};