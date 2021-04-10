
// $(document).ready("turbolinks:load", () => {
//   $('[data-tooltip-display="true"]').tooltip(),
//   flatpickr("[class='flatpickr']", {})
// });

add_new_item_type = function () {
  if ($("#item_item_type_id option:selected").text() == "Add New Item Type") {
    $("#new_item_type").show();
  } else {
    console.log($("#item_item_type_id option:selected").text());
    $("#new_item_type").hide();
  }
};

add_new_item = function () {
  $("#new_item").show();
};

add_new_purchase_type = function () {
  if ($("#purchase_purchase_type_id option:selected").text() == "Add New Purchase Type") {
    $("#new_purchase_type").show();
  } else {
    console.log($("#purchase_purchase_type_id option:selected").text());
    $("#new_purchase_type").hide();
  }
};

add_new_authentication = function () {
  if ($("#autograph_authentication_id option:selected").text() == "Add New Authentication") {
    $("#new_authentication").show();
  } else {
    console.log($("#autograph_authentication_id option:selected").text());
    $("#new_authentication").hide();
  }
};


$("#purchase_date").flatpickr(); // jQuery

// $("#purchase_date").keyup(function(e){
//   var key=String.fromCharCode(e.keyCode);
//   if(!(key>=0&&key<=9))$(this).val($(this).val().substr(0,$(this).val().length-1));
//   var value=$(this).val();
//   if(value.length==2||value.length==5)$(this).val($(this).val()+'-');
// });

document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    allowInput: true,
    altFormat: 'F j, Y',
    dateFormat: "m/d/Y"
  });

  var format = "mm/dd/yyyy";
  var match = new RegExp(format
    .replace(/(\w+)\W(\w+)\W(\w+)/, "^\\s*($1)\\W*($2)?\\W*($3)?([0-9]*).*")
    .replace(/m|d|y/g, "\\d"));
  var replace = "$1/$2/$3$4"
    .replace(/\//g, format.match(/\W/));

  function doFormat(target) {
    target.value = target.value
      .replace(/(^|\W)(?=\d\W)/g, "$10")   // padding
      .replace(match, replace)             // fields
      .replace(/(\W)+/g, "$1");            // remove repeats
  };

  $("#purchase_date").keyup(function (e) {
    if (!e.ctrlKey && !e.metaKey && (e.keyCode == 32 || e.keyCode > 46))
      doFormat(e.target)
  });

});





/*$(document).ready(function(e){
  $('.search-panel .dropdown-menu').find('a').click(function(e) {
  e.preventDefault();
  var param = $(this).attr("href").replace("#","");
  var concept = $(this).text();
  $('.search-panel span#search_concept').text(concept);
  $('.input-group #search_param').val(param);
});
});*/


