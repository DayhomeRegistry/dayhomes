/* 
*  Place all the behaviors and hooks related to the matching controller here.
*  All this logic will automatically be available in application.js.
*  You can use CoffeeScript in this file: http://coffeescript.org/
*/

var signedIn=false;
function goNext(){
	alert('goNext');
}
var care_type_set = false;
var city_set = false; 
function enableNext(){
	var button = $('#js-submit-button button');
	if((care_type_set&&city_set)) {
		button.prop('disabled',false);
		button.removeClass('disabled')
	} else {
		button.prop('disabled',true);
		button.addClass('disabled')
	}

}
$(document).ready(function(){

	$('.fieldset_care_type .btn').on("click", function(){
		var fieldset = $(this).parents(".fieldset");
		var button_group = $(this).parents(".btn-group");
		var active_selection = fieldset.find(".active-selection");
		var type = $(this).attr("data-type");
		if ($(this).attr('data-slug') == 'professional') {
			var text = 'A private dayhome operating purposefully and professionally.';
		} else if ($(this).attr('data-slug') == 'accredited') {
			var text = 'An accredited dayhome working under the auspices of a Goverment Agency.';
		} else if ($(this).attr('data-slug') == 'agency') {
			var text = 'A Government Agency.';
		}
		active_selection.find(".title-value").text(type);
		active_selection.find(".active-message").text(text);
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
	$('#js-submit-button button').on("click",function(){
		
		if (!signedIn) {
			//login
        	$( "#signInForm" ).modal('show');
		} else {
			//Submit the form
			goNext();
		}
	});
	var completer = new GmapsCompleter({
		inputField: '#location_input',
		errorField: '#location_error'
	});

	completer.autoCompleteInit({
		region: 'AB',
		country: "Canada",
		autocomplete: {
		    minLength: 4,
		    close: function(event, ui) {
		    	city_set=true;
		    	enableNext();
		    },
		    change: function(event, ui) {
		    	city_set=true;enableNext();
		    }
		}
	});
	$("form#signin-form").bind("ajax:success", function(e, data, status, xhr){
		if (data.success) {
		  $( "#signInForm" ).modal('hide');
		  goNext();
		}else{
			$( "#signInForm" ).modal('hide');
		  	alert('Seems we couldn\'t log you in!')
		}
	});
	$("form#signup-form")
		.bind("ajax:success", function(e, data, status, xhr){
			if (data.success) {
			  $( "#signInForm" ).modal('hide');
			  goNext();
			}else{
				//Parse the errors
				var errors = JSON.parse(data.errors);
				var fields = [];
				for(var k in errors) {
					var element = $("form#signup-form").find("[name*='user["+k+"]']");
					element.after($("<span class='error'>"+errors[k]+"</span>"))
				}
				// $( "#signInForm" ).modal('hide');
			 //  	alert('Seems we couldn\'t sign you up!')
			}
		})
		.bind("ajax:error",function(e, xhr, status, error){
			alert("error")
		});
	$('#signin-using-email').on("click",function(){
		$(this).hide();
		$('#signin-form').show();
	});
	$('#sign-up-link').on("click",function(){
		$('#signinPage').hide();
		$('#signupPage').show();
	});
	$('#create-using-email').on("click",function(){
		$(this).hide();
		// $('.modal-content').height("500px");
		// $('.modal-body').height("500px");
		$('#tos_outside').hide();	
		$('#signup-form').show();
	});
	$('#show-login').on("click",function(){
		$('#signupPage').hide();
		$('#signinPage').show();
	});

});