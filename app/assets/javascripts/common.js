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
			speed: 		600,
			timeout: 	5000
		});
	});

}(jQuery));