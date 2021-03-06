/* 
*  Place all the behaviors and hooks related to the matching controller here.
*  All this logic will automatically be available in application.js.
*  You can use CoffeeScript in this file: http://coffeescript.org/
*/

function goNext(){
	//beta
	//$('#create_form').submit();
	var data = {
		dayhome: {
			care_type_id: $('#care_type_id').val(),
  			capacity: $('#accomodates-select').find('option').filter(":selected").val(),
  			title: $('#title').val(),
  			city: $('#city').val()
		}
	};
	var params = {
	    dataType: "json",
	    type: "POST",
	    url: "/beta/dayhomes",
	    data: data
	};
	$(document).ajaxSend(function (e, xhr, options) {
	  	xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'));
	});
	$.ajax(params).done(function(data) {
		if(data.success) {
			window.location = data.url;
		} else {
			$("#flash-messages").append($('<div class="flash alert alert-danger">'+data.error+'</div>'));
		}

	});
}
var care_type_set = false;
var city_set = false; 
var title_set = false;
function enableNext(){
	var button = $('#js-submit-button button');
	if((care_type_set&&city_set&&title_set)) {
		button.prop('disabled',false);
		button.removeClass('disabled')
	} else {
		button.prop('disabled',true);
		button.addClass('disabled')
	}

}
$(document).ready(function(){
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }
	});

	$('.fieldset_care_type .btn').on("click", function(){
		var fieldset = $(this).parents(".fieldset");
		var button_group = $(this).parents(".btn-group");
		var active_selection = fieldset.find(".active-selection");
		var input = $('#care_type_id');
		var type = $(this).attr("data-type");
		var type_id= $(this).attr("data-type-id");
		if ($(this).attr('data-slug') == 'professional') {
			var text = 'A private dayhome operating purposefully and professionally.';
		} else if ($(this).attr('data-slug') == 'accredited') {
			var text = 'An accredited dayhome working under the auspices of a Goverment Agency.';
		} else if ($(this).attr('data-slug') == 'agency') {
			var text = 'A Government Agency.';
		}
		active_selection.find(".title-value").text(type);
		active_selection.find(".active-message").text(text);
		input.val(type_id);
		button_group.hide();
		active_selection.show();
		care_type_set=true;
		enableNext();
	});
	$('#change-care-type').on("click", function(){
		var fieldset = $(this).parents(".fieldset");
		var button_group = fieldset.find(".btn-group");
		var active_selection = fieldset.find(".active-selection");
		button_group.show();
		active_selection.hide();
		care_type_set=false;
		enableNext();
	});
	$('#accomodates-select').on("change",function(){
		var input = $('#capacity');
		var capacity = $(this).find('option').filter(":selected").val()
		input.val(capacity);
	});
	$('#title_input').on("change",function(){
		var input = $('#title');
		var title = $('#title_input').val();
		input.val(title);
		title_set=true;
		enableNext();
	});
	$('#js-submit-button button').on("click",function(){
		
		// $.when($.signedIn()).done(function(val) {
		// 	//update the form token...apparently it changes when you login (new session?)
		// 	$('input[name="authenticity_toke"]').val(val);
		// 	$('meta[name="csrf-token"]').attr('content',val);
		// 	//Submit the form
		// 	goNext();
		// });
		$('#create_form').submit();
	});
	var completer = new GmapsCompleter({
		inputField: '#location_input',
		errorField: '#location_error'
	});
	completer.update = function(){
		var input = $('#city');
		var city = $('#location_input').val();
		input.val(city);
		city_set=true;
		enableNext();
	};
	completer.autoCompleteInit({
		region: 'AB',
		country: "Canada",
		autocomplete: {
		    minLength: 4,
		    close: function(event, ui) {
		    	completer.update();
		    },
		    change: function(event, ui) {
		    	completer.update();
		    }
		}
	});
	

});