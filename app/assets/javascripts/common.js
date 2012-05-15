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

		// Make slides autoplay
		$(".slides").cycle({
			fx: 		"fade",
			speed: 		300,
			timeout: 	10000
		});
	});

}(jQuery));