console.log("LOADING");
var item_search = function(){
  console.log("I am here");
  $input = $('#item-search')

  var options = {
    url: function(phrase) {
      return "/items/search.json?q=" + phrase;
    },
    placeholder: "Search for Item",
    getValue: "name",
    template: {
      type: "description",
      fields: {
        description: "type"
      }
    },
    list: {
      onClickEvent: function() {
        $("#item-search-result").show();
        var index = $("#item-search").getSelectedItemData();
        if(jQuery.isEmptyObject(index)) {
          $("#item-search-result").hide();
          $("#result-name").text('').trigger("change");
          $("#result-desc").text('').trigger("change");
        } else {          
        $("#result-name").text(index.name).trigger("change");
        $("#result-desc").text(index.type).trigger("change");
        $.ajax({
          url: "/autographs/get_item",
          type: "POST",
          data: {"item_id" : index.id},
          dataType: "json"
          });
        }
      }
    }
  };

    console.log(options);
  $input.easyAutocomplete(options);
 
};

$(document).ready(item_search);
$(document).on('turbolinks:load', item_search);


