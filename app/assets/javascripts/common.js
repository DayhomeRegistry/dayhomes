(function($, undefined){
	$.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader("Accept", "text/javascript");
	    }
	});

	function log(text) {
	  if(window && window.console) console.log(text);
	}

	$(function() {
		$("input[placeholder]").placeholder();
	});
}(jQuery));