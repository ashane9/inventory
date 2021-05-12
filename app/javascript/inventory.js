
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

add_new_authentication = function (index) {
  if ($("#authentication_id_".concat(index).concat(" option:selected")).text() == "Add New Authentication") {
    $("#new_authentication_".concat(index)).show();
  } else {
    console.log($("#authentication_id_".concat(index).concat(" option:selected")).text());
    $("#new_authentication_".concat(index)).hide();
  }
};

add_new_profession = function () {
  if ($("#autograph_profession_id option:selected").text() == "Add New Profession") {
    $("#new_profession").show();
  } else {
    console.log($("#autograph_profession_id option:selected").text());
    $("#new_profession").hide();
  }
};

add_new_organization = function () {
  if ($("#autograph_organization_id option:selected").text() == "Add New Organization") {
    $("#new_organization").show();
  } else {
    console.log($("#autograph_organization_id option:selected").text());
    $("#new_organization").hide();
  }
};

var formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'});

formatCurrency = function (target) {
  if (target.value.length === 0 || target.value == '$') {
    target.value = '$0.00';
  } else {
    target.value = '$'.concat(target.value.replace(/[^\d]/g,'').replace(/(\d\d?)$/,'.$1').replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,").replace(/^[0](,|(\d))/,'$2'));
  }
};

document.addEventListener("turbolinks:load", () => {

  flatpickr("[data-behavior='flatpickr']", {
    allowInput: true,
    altInput: true,
    altFormat: 'm/d/Y',
    dateFormat: "Y-m-d",
    onReady(){
      if (this.altInput) {
       this.altInput.id = this.input.id;
       this.input.id = '';
    }}
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

  var dateKeyupCapture = function (e) {
    if (!e.ctrlKey && !e.metaKey && (e.keyCode == 32 || e.keyCode > 46))
      doFormat(e.target)
  }; 

  //ID is autogenerated using controller and field name
  $("#purchase_date").on("keyup",dateKeyupCapture);
  $("#value_as_of_date").on("keyup",dateKeyupCapture);
  $("#autograph_autograph_date").on("keyup",dateKeyupCapture);

  //total cost of purchase
  sum_total_cost = function () {
    var cost = (parseFloat($("#sale_price").val().replace(/[$]/,'')) || 0) + (parseFloat($("#buyer_premium").val().replace(/[$]/,'')) || 0) + (parseFloat($("#shipping").val().replace(/[$]/,'')) || 0) + (parseFloat($("#additional").val().replace(/[$]/,'')) || 0) - (parseFloat($("#discount").val().replace(/[$]/,'')) || 0);
    $("#total_cost").text(formatter.format(cost));
  };
  $("#sale_price").on("keyup",function(e){
    formatCurrency(e.target); 
    sum_total_cost();
  });
  $("#buyer_premium").on("keyup",function(e){
    formatCurrency(e.target);    
    sum_total_cost();
  });
  $("#shipping").on("keyup",function(e){
    formatCurrency(e.target); 
    sum_total_cost();
  });
  $("#additional").on("keyup",function(e){
    formatCurrency(e.target); 
    sum_total_cost();
  });
  $("#discount").on("keyup",function(e){
    formatCurrency(e.target); 
    sum_total_cost();
  });
  
  //estimated value
  $("#estimated_value").on("keyup",function(e){
    formatCurrency(e.target); 
  });

  //autograph authentication...start
  var autoAuthIndex = '0';

  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('div.auth_row').remove();
    //working on deleting autoAuthIndex
    // $(this).siblings('div').children('div[id]')
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    console.log("here");
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    console.log(regexp);
    
    console.log(autoAuthIndex);
    autoAuthIndex = (parseInt(autoAuthIndex) + 1).toString();
    console.log(autoAuthIndex);

    $('.auth_fields').append($(this).data('fields')
    .replace(regexp, time)
    .replace(/_[0-9]/g, '_'.concat(autoAuthIndex))
    .replace(/\[[0-9]\]/g, '['.concat(autoAuthIndex,']'))
    .replace(/\([0-9]\)/g, '('.concat(autoAuthIndex, ')'))
    );
    return event.preventDefault();
  });
   //autograph authentication...end

});



