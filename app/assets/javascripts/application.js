// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery.browser
//= require bootstrap
//= require fullcalendar
//= require underscore
//= require jquery.serializejson
// require gmaps/google
//= require jquery.add_more
//= require jquery.colorbox
//= require jquery.modal
//= require jquery.rest
//= require jquery-star-rating
//= require jquery.cycle.lite
//= require jquery.scrollTo
//= require common
//= require externals/modernizr
//= require externals/html5support/jquery.html5support
//= require class
// require infobox_packed.js
// require markerclusterer.min.js
// require richmarker-compiled.js
// require gmaps-auto-complete

// require maps.google.com.js

function isPrintableKey(e){if(e.altKey||e.ctrlKey||e.metaKey)return!1;var t=e.which;return t<32||t==144?!1:!0}
function integersonly(e,t){
  var n=jQuery.event.fix(t||window.event),r=n.which,i=String.fromCharCode(r);
  return r===undefined?!0:isPrintableKey(n)?"0123456789".indexOf(i)>-1?!0:!1:!0;
}
function roundFloat2(e){
  return isNaN(e)&&(e=0),String(Number(e).toFixed(2))
}
window.numbersonly2=integersonly;
window.roundFloat2=roundFloat2;
$(document).ready(function(){
	$('.icon-info-sign').popover() ;
});
