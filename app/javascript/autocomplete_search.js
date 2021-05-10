
var item_search = function() {
  $("#item-search").autocomplete({
    source: '/items/search',
    select: function( event, ui ) {  
      $("#item-search-result").show();
      $("#result-name").text(ui.item.value).trigger("change");
      $("#result-desc").text(ui.item.description).trigger("change");
      $.ajax({
        url: "/autographs/get_item",
        type: "POST",
        data: {"item_id" : ui.item.id},
        dataType: "json"
        });
    }
  });

  $("#item-search").on("search", function(event) {
    console.log("search clear");
    if($("#item-search").value == null){
      $("#result-name").text('').trigger("change");
      $("#result-desc").text('').trigger("change");
      $.ajax({
        url: "/autographs/get_item",
        type: "POST",
        data: {"item_id" : null},
        dataType: "json"
        });
      return false;
    }
  }); 
};

$(document).on('turbolinks:load', item_search);