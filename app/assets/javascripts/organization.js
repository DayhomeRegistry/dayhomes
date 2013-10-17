Dayhome.editPage.Organization = Class.extend({
	defaults: {
        form: 'form[id^="edit_organization"]',        
    },

    // 'Constructor'
    init: function (options) {
        
        this.options = jQuery.extend({}, this.defaults, options);
        this.getElements();
        this.bindEvents();
    },

    getElements: function () {
	    this.CREDIT_CARD_NUMBER = $('#card_number');
        this.CVV = $('#card_code');

        this.submitButton = $('#submit-button');
    },

	bindEvents: function () {
		var self = this;

        $(this.options.form).bind('submit', function (event) {
            self.handleForm( self, event );
        });

	},
	/*
    Event handler for form submissions and validates form data before sending it
    */
    handleForm: function (self, event) {
    	var ccnum = $('#card_number').val(),
            isnum = /(^\d+$)|(^\d+\.\d+$)/,
            now = new Date(),
            curyear = now.getFullYear(), curmonth = now.getMonth() + 1,
            expyear = $('#card_year').val(),
            expmonth = $('#card_month').val(),
            curdate = new Date(curyear, curmonth, 1).getTime(),
            expdate = new Date(expyear, expmonth, 1).getTime(),

        validators = {
            "CREDIT_CARD_NUMBER": "You must enter your credit card number.",
            "CVV":"You must enter your Card Verification Value."
        };

        // if doing a downgrade, don't validate these fields as they are not required
        if ($('#newCard').is(':hidden')) {
            delete validators.CREDIT_CARD_NUMBER;
            delete validators.CVV;
        }
            
        if (!build_validator(validators)(this)) {
            event.preventDefault();
            return false;
        }

        if (validators.CREDIT_CARD_NUMBER && !isnum.test(ccnum)) {
            alert("Please re-enter your credit card number using only numbers.");
            $('#card_number').focus();
            event.preventDefault();
            return false;
        }
        if (validators.CREDIT_CARD_NUMBER && expdate < curdate) {
            alert("Your expiry date is in the past.");
            $('#card_month').focus();
            event.preventDefault();
            return false;
        }

        // Disable the button.
        self.submitButton.val('Saving…').prop('disabled', true);

        if (!$('#newCard').is(':hidden')) {
          var card = {
              number: $('#card_number').val(),
              cvc: $('#card_code').val(),
              expMonth: $('#card_month').val(),
              expYear: $('#card_year').val()
          };
          Stripe.createToken(card, self.handleStripeResponse);
          event.preventDefault();
          return false;
        } 
        //we just submit the form
        return true;
    },
    handleStripeResponse: function (status, response) {
      if(status == 200) {
        $('input[name$="[stripe_card_token]"]').val(response.id);
        $('form')[0].submit();
      } else {
        // Enable the button.
        $('#submit-button').val('Save Changes').prop('disabled', false);

        $('#stripe_error').text(response.error.message);        
        $('input[type=submit]').attr('disabled',false);
      }
    }
});
var org = new Dayhome.editPage.Organization();