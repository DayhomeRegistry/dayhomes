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
	    }
	  );
	// Overview
	$('[id^="tooltip-help"]')
		.on("focusin",function(){
			$('[data-trigger="#'+$(this).attr('id')+'"]').show();
		})
		.on("focusout",function(){
			$('[data-trigger="#'+$(this).attr('id')+'"]').hide();
		})
	$('input.form-control,textarea.form-control').on("change",function(){
		var data = {};
		data[$(this).attr("name")]= $(this).val();
		var params = {
		    dataType: "json",
		    type: "POST",
		    url: getCurrentPath()+$(this).attr("data-url"),//"/setTitle",
		    data: data
		};
		resetSavingStatus();
		$('.js-saving-progress h5').show();
		$.ajax(params).done(function(data) {
			setSavingStatus(data);
		});
	});
	$('.countable').on("keyup",function(){
		var val = parseInt(characterCount($(this).val()));
		$('#js-count-'+$(this).attr("name")+" span").text($(this).attr("maxlength")-val);
	})
	$('#js-write-more').on("click",function(){
		$('.more').hide();
		$('#tooltip-help-description').show();
	});
});