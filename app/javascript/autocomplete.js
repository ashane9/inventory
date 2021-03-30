console.log("LOADING");
var item_search = function(){
  console.log("I am here");
  $input = $('#item-search')

  var options = {
    url: function(phrase) {
      return "/items/search.json?q=" + phrase;
    },
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
        console.log(index);
  
        $("#result-id").text(index.id).trigger("change");
        $("#result-name").text(index.name).trigger("change");
        $("#result-desc").text(index.type).trigger("change");
      }
    }
  };

    console.log(options);
  $input.easyAutocomplete(options);
 
};

$(document).ready(item_search);
$(document).on('turbolinks:load', item_search);


