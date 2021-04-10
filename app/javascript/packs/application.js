// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("bootstrap")
require("inventory")
require("easy-autocomplete")  
require("autocomplete")
import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.css"
import "@fortawesome/fontawesome-free/css/all"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require turbolinks
//= require jquery
//= require jquery3
//= require jquery-ui
//= require popper
//= require_tree .

if(navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/Android/i)
|| navigator.userAgent.match(/BlackBerry/i) || navigator.userAgent.match(/IEMobile/i)){
    $("#viewport_device").attr("content", "initial-scale = 0.50");
}
else if(navigator.userAgent.match(/iPad/i)){
    $("#viewport_device").attr("content", "initial-scale = 1.00");
}