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

  function validate_field(name, value, field) {
        var postData = { };
        postData['field'] = name;
        postData['value'] = value;
        $.post('/contacts/validate', postData, function(data) {
                if(data.valid==false) {
                        $(field).parent('p').addClass('fieldWithErrors');
                        $(field).next('span').remove();
                        $(field).after('<span class="inlineError">'+ data[name] +'</span>');
                }else{
                        $(field).parent('p').removeClass('fieldWithErrors');
                        $(field).next('span').fadeOut(200, function() { $(this).remove(); });                        
                }                                                        
        }, 'json');        
  }

  // General delay function, used to watch keyups,
  // Taken from: http://stackoverflow.com/questions/1909441/jquery-keyup-delay
  var delay = (function(){
    var timer = 0;
    return function(callback, ms){
      clearTimeout (timer);
      timer = setTimeout(callback, ms);
    };
  })();

  // Checks an array for a passed value
  Array.prototype.in_array = function(p_val) {
          for(var i = 0, l = this.length; i < l; i++) {
                  if(this[i] == p_val) {
                          return true;
                  }
          }
          return false;
  }

  // Allows for AJAX
  // Taken from http://henrik.nyh.se/2008/05/rails-authenticity-token-with-jquery
  $(document).ajaxSend(function(event, request, settings) {
    if (typeof(AUTH_TOKEN) == "undefined") return;
    // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
    settings.data = settings.data || "";
    settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
  });

}(jQuery));