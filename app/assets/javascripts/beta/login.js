var signedIn=false;
var signInPromise;
$.signedIn = function(){
	if(signInPromise == null || signInPromise.state()!="pending")
		signInPromise = new $.Deferred();

	if (!signedIn) {
		//login
		$( "#signInForm" ).modal('show');
	} else {
		signInPromise.resolve();
	}
	return signInPromise;
}
$(document).ready(function(){
	$("form#signin-form").bind("ajax:success", function(e, data, status, xhr){
		if (data.success) {
		  	$( "#signInForm" ).modal('hide');
		  	signInPromise.resolve();
		}else{
			$( "#signInForm" ).modal('hide');
			signInPromise.reject('Seems we couldn\'t log you in!')
		}
	});
	$("form#signup-form")
		.bind("ajax:success", function(e, data, status, xhr){
			if (data.success) {
			  $( "#signInForm" ).modal('hide');
			  signInPromise.resolve();
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


		//Do call back from facebook auth
	if(window.opener && (window.opener.$('#signupPage').filter(':visible')||window.opener.$('#signinPage').filter(':visible'))) {
		window.opener.goNext();
		window.close();

	}
});