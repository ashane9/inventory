console.log("LOADING");
// var item_search = function(){
//   // $(document).on('turbolinks:load', () => {
//   console.log("item_search called");
//   $("#item-search").keyup(function(){
//     var text = this.value;
    
//   console.log(text);
//     if (text.length >= 2 ) {
//      $.ajax({
//         type: "get",
//         url: "/items/search",
//         data: { q: text },
//         success: function(response) {
//           show_data(response)
//           $("#item-search-result").css("display", "block");
//         }
//       });
//     }
//   });
//   function show_data(tags) {
//      $("#item-search").autocomplete({
//       source: tags
//     });
//   }
// // });
// };


// $(document).ready(item_search);
// $(document).on('turbolinks:load', item_search);


// import 'js-autocomplete/auto-complete.css';
// import autocomplete from 'js-autocomplete';

// const renderItem = function (item) {
//     let icon;
//     icon = '<i class="fas fa-code"></i>';

//     return `<div class="autocomplete-suggestion">${icon}<span>${item.name}</span></div>`
// };

// const autocompleteSearch = function() {
//   console.log("item_search called");
//   const items = JSON.parse(document.getElementById('item-search').dataset.skills)
//   const searchInput = document.getElementById('q');

//   if (items && searchInput) {
//     new autocomplete({
//       selector: searchInput,
//       minChars: 1,
//       source: function(term, suggest){
//         $.getJSON('/items/search',
//           { q: term },
//           function(data) {
//             return data;
//         }).then((data) => {
//           const matches = []
//           data.search.forEach((item) => {
//             matches.push({name: item.item_name });
//           });
//           suggest(matches)
//         });
//       },
//       renderItem: renderItem,
//     });
//   }
// };

// export { autocompleteSearch };

var item_search = function() {
  $("#item-search").autocomplete({
    source: '/items/search',
    select: function( event, ui ) {  
      // item = ui.item.id;
      $("#item-search-result").show();
      $("#result-name").text(ui.item.label).trigger("change");
      $("#result-desc").text(ui.item.description).trigger("change");
      $.ajax({
        url: "/autographs/get_item",
        type: "POST",
        data: {"item_id" : ui.item.id},
        dataType: "json"
        });
    //   // $("#result-desc").text(index.type).trigger("change");
      // return false;      
    }
  });

  // $("#item-search").on( "autocompleteselect", function( event, ui ) {
  //   console.log(ui.item.value);
  //   $("#item-search-result").show();
  //   $("#result-name").text(ui.item.value).trigger("change");
  // } );
  $("#item-search").on("search", function(event) {
    console.log("search clear");
    if($("#item-search").value == null){
      $("#item-search-result").hide();
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

$(document).ready(item_search);
$(document).on('turbolinks:load', item_search);