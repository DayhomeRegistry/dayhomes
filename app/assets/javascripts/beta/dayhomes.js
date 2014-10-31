function characterCount(text){
	//Hack for the fact that Chromium doens't seem to count carriage returns properly for maxlength
	//https://code.google.com/p/chromium/issues/detail?id=158652
	return text.length+(text.match(/\n/g)|| []).length
}
function getCurrentPath() {
	var url = document.URL;
	return url.substring(0,url.lastIndexOf("/"));
}
function resetSavingStatus(){
	$('.js-saving-progress h5').hide(); //just in case
	$('.js-saving-progress').addClass('saving-progress');
	$('.js-saving-progress').removeClass('saving-error');
	$('.js-saving-progress h5').text('Saving...');
}
function setSavingStatus(data) {
	if(data.success) {
		$('.js-saving-progress h5').text('Saved.');
		setTimeout(function() {
		    $('.js-saving-progress h5').fadeOut('fast');
		}, 2000);
	} else {
		$('.js-saving-progress').removeClass('saving-progress');
		$('.js-saving-progress').addClass('saving-error');
		$('.js-saving-progress h5').text('Uh oh: '+data.errors);
	}
}
// Convert dataURL to Blob object
function dataURLtoBlob(dataURL) {

  // Decode the dataURL
  var binary = atob(dataURL.split(',')[1]);

  // Create 8-bit unsigned array
  var array = [];
  for(var i = 0; i < binary.length; i++) {
    array.push(binary.charCodeAt(i));
  }

  // Return our Blob object
  return new Blob([new Uint8Array(array)], {type: 'image/png'});
}
function updateStepComplete(){
	var span = $('li.active span');
	if($('.photo-wrapper').length<=0){
		//update the checkmark
		span.removeClass('glyphicon-ok');
		span.addClass('glyphicon-remove');
		$('.js-next-btn').attr('disabled','disabled');
		$('.js-next-btn').addClass('disabled');	
	} else {
		span.removeClass('glyphicon-remove');
		span.addClass('glyphicon-ok');
		$('.js-next-btn').removeAttr('disabled');
		$('.js-next-btn').removeClass('disabled');

	}
	updateStepCount();
}
$(document).ready(function(){
	$('.fileinput').fileinput()
	$('.fileinput').on("change.bs.fileinput", function(){
		// var data = {};
		// data['image']=$(this).find('.fileinput-preview img').attr('src');
		// Get our file
		var file= dataURLtoBlob($(this).find('.fileinput-preview img').attr('src'));

		// Create new form data
		var fd = new FormData();

		// Append our Canvas image file to the form data
		fd.append("image", file);
		var params = {
		    //dataType: "json",
		    type: "POST",
		    url: getCurrentPath()+"/addPhoto",
		    data: fd,
		    processData: false,
		    contentType: false,
		};
		resetSavingStatus();
		$('.js-saving-progress h5').show();
		$.ajax(params).done(function(data) {
			setSavingStatus(data);
			if(data.success) {
				//need to clear the loader and add the image
				$('.fileinput').fileinput('clear');

				var div = $('<div class="col-lg-4 col-sm-6 col-xs-12 photo-wrapper">');
				div.append($(data.template));
				$('.photo-grid').append(div)
				updateStepComplete();
			}
		}).error(function( jqXHR, textStatus, errorThrown ){
			setSavingStatus({success:false, errors: errorThrown});
		});
	});
	$(document.body)
		.on('ajax:success', '.link-delete', function() {
	      $(this).parents('.photo-wrapper').remove();
	      updateStepComplete();
	    })
	    .on('ajax:error', '.link-delete', function() {
	      alert("crap");
	    });
	$(document.body)
		.on('ajax:success', '.link-set-default', function() {
	      $(document.body).find('.default').removeClass('default');
	      $(this).find('.image-fieldset').addClass('default');
	      $('.image-legend .set-default-link').show();
	      $('.image-legend .default-text').hide();
	      $(this).find('.set-default-link').hide();
	      $(this).find('.default-text').show();
	      $('.link-set-default').each(function(){
	      	$(this).data("method","post");
	      	$(this).data("remote",true);
	      	$(this).attr("href",$(this).attr("data-set-default-link"));
	      });
	      $(this).removeAttr("data-method");
	      $(this).removeAttr("data-remote");
	      $(this).attr("href",$(this).attr("data-photo-url"));

	    })
	    .on('ajax:error', '.link-set-default', function(jqXHR, textStatus, errorThrown ) {
	      alert("crap");
	    });
	// Overview
	$('[id^="tooltip-help"]')
		.on("focusin",function(){
			$('[data-trigger="#'+$(this).attr('id')+'"]').show();
		})
		.on("focusout",function(){
			$('[data-trigger="#'+$(this).attr('id')+'"]').hide();
		})
	function submit($element, data) {
		var params = {
		    dataType: "json",
		    type: "POST",
		    url: getCurrentPath()+$element.attr("data-url"),//"/setTitle",
		    data: data
		};
		resetSavingStatus();
		$('.js-saving-progress h5').show();
		$.ajax(params)
			.then(function(data) {
				setSavingStatus(data);
			})
			.fail(function(data){
				setSavingStatus({errors: data.statusText});
			});
	}
	$(document.body).on("change", 'input.form-control,textarea.form-control',function(){
		var parent = $(this).parents('.js-submit-group')[0];
		
		var data = {};
		if(parent) {
			var timeoutId = $(parent).data('tid');
			if(timeoutId) {
				//we've changed something else since the timer was set, clear it
				clearTimeout(timeoutId);
			}
			data["address"]={}
			address = data["address"]
			$(parent).find('input.form-control, textarea.form-control').each(function(){
				element = $(this).serializeJSON();
				$.extend(true,address,element);
			});
			var tid = setTimeout(function(){
		        submit($(parent),data);
		    }, 3000);

		    $(parent).data('tid', tid);
		} else {
			data[$(this).attr("name")]= $(this).val();
			submit($(this),data);
		}
		
	});
	$('input').focus(function () {
	    var $parent = $(this).closest('div');
	    var timeoutId = $parent.data('tid');

	    if (timeoutId) {
	        // Aborting the blur
	        clearTimeout(timeoutId);
	    }

	    $parent.addClass('focused');
	}).blur(function () {
	    var $parent = $(this).closest('div');

	    var tid = setTimeout(function(){
	        $parent.removeClass('focused');
	    }, 1);

	    $parent.data('tid', tid);
	})
	$(document.body).on("keyup", '.countable',function(){
		var val = parseInt(characterCount($(this).val()));
		$(this).siblings('#js-count-'+$(this).attr("name")).find("span").text($(this).attr("maxlength")-val);
	})
	$('#js-write-more').on("click",function(){
		$('.more').hide();
		$('#tooltip-help-description').show();
	});
});