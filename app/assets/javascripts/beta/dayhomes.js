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
$(document).ready(function(){

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