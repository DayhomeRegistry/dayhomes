

Dayhome.billingPage.Billing = Class.extend({
	defaults: {
        form: '#billing-form',
        update_triggers: '#staff, #locales, #day_home_signup_request_coupon',
        keys: {
            staff: 'staff',
            locales: 'locales'
        },        
        numberClass: '.num',
        amountClass: '.amount',
        coupon: '#day_home_signup_request_coupon'
    },
    //elements used to display the currently selected pricing info
    costElements: {},

    //containers for the inputs.
    inputContainers: {},

    //inputs to read data from.
    inputs: {},

    //limits for the new package
    newLimits: {},

    //discounts
    discountAmount: 0,
    discountType: null,
    couponMessageDisplayed: false,
    
    // 'Constructor'
    init: function (options) {
        
        this.options = jQuery.extend({}, this.defaults, options);
        this.getElements();
        this.bindEvents();
    },

    getElements: function () {
    	
        for (var name in this.options.keys) {
            this.inputs[name] = $('#' + name);
            this.inputContainers[name] = $('#addon_' + name);
            this.costElements[name] = $('#total_box_' + name);
            this.newLimits[name] = $('#limit_' + name);
        }
        
        this.packageInput = $('#choose-package');
        this.plan = $('#plan');
        this.CREDIT_CARD_NUMBER = $('#card_number');
        this.CVV = $('#card_code');
        //this.country = $('#p_country');
        //this.is_mobile = $('#is_mobile');

        this.frequencyBox = $('#green_box');
        this.payNowButton = $('#pay-now-button');
        //make sure the button is setup correctly
        this.checkPackageSwitch();
    },

	bindEvents: function () {
        var self = this;

        $(this.options.form).bind('submit', function (event) {
            self.handleForm( self, event );
        });
        // List of all the things which can affect pricing 
        
        $(this.options.update_triggers).bind('change', function () {
            if(this===$(self.options.coupon).get(0))
                self.couponMessageDisplayed=false;
            self.update();
        });

        $('#choose-package').bind('change', function (event) {
            self.checkPackageSwitch();
        });

    },
    
    get_additional_value: function (type) {
        return parseInt($('#' + type + ':enabled').val(), 10) || 0;
    },
    isSelectedPackageFree: function(){
        var base_package = Dayhome.billingPage.existing;
        var packageid = Number(this.packageInput.val());
        if (packageid && Dayhome.billingPage.packages[packageid]) {
            base_package = Dayhome.billingPage.packages[packageid];
        }
        return base_package.price == 0;
    },
    isCurrentPackageFree: function () {
        var base_package = Dayhome.billingPage.existing;
        return base_package.price == 0;
    },
    checkPackageSwitch: function (event) {
        var packageid = Number(this.packageInput.val());
        var self = this;
        if (this.isSelectedPackageFree())
        {
            $('#credit-card-section').hide();
            if(!this.isCurrentPackageFree()) {
              this.payNowButton.val('Downgrade');
            } else {
              this.payNowButton.val('Signup Now');
            }
        } else {
            $('#credit-card-section').show();
            this.payNowButton.val('Pay Now');
        }
        self.update();        
    },

    update: function () {
        
        var packageid = this.packageInput.val();

        //Figure out the discount, if any

        this.discountAmount = 0;
        this.discountType= null;
        billing = this;

        jqCoupon = $(this.options.coupon);
        coupon = jqCoupon.val();
        if (coupon){
            //Validate the coupon
            // var success=1;
            $.ajax({
              url: $('form')[0].action.substring(0,$('form')[0].action.lastIndexOf('/'))+"/get_coupon",
              data: {"coupon":coupon},
              dataType: 'json',
              async: false
            })
            .done(function(data, text, xhr){
              //alert("success: "+data);
              $(billing.options.coupon).closest('div[class^="control-group"]').removeClass('error').addClass('success')
              if(data.percent_off) {
                billing.discountAmount = data.percent_off;
                billing.discountType= 'percent';
              } else if (data.amount_off) {
                billing.discountAmount = data.amount_off/100;
                billing.discountType= 'dollar';
              }
              
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                if(!billing.couponMessageDisplayed){
                    if(jqXHR.responseText){
                        alert(jqXHR.responseText);
                        billing.couponMessageDisplayed=true;
                    }
                }
                jqCoupon.closest('div[class^="control-group"]').removeClass('success').addClass('error')
            }); 

               
        } else {
            $(this.options.coupon).closest('div[class^="control-group"]').removeClass('error').addClass('success')
        }

        //update the details on the page.
        var period_total = this.updateDetails(packageid);

        if (period_total.toFixed(2)<=0) {
            $('#credit-card-section').slideUp().find('input, select').prop('disabled', true);
        } else {
            $('#credit-card-section').slideDown().find('input, select').prop('disabled', false);
        }

        var pay_yearly = this.getYearly();

        var province = $('#others');
        if (!province.is(':enabled')) {
            province = $('select[name=state_or_province]:enabled');
        }


/*
        var heading = $('#choose-subscription'),
			method = 'show';

        this.frequencyBox.html(data);

        // If there are no visible inputs there is no choice, hide the text indicating choice.
        if (_this.frequencyBox.find('input:visible').length === 0) {
            method = 'hide';
        }
        heading[method]();

        var valid_discount = $('#new_discount_valid_text').val();
        $('#discount_valid_text').text(valid_discount);

        var invalid_discount = $('#new_discount_invalid_text').val();
        $('#discount_invalid_text').text(invalid_discount);
        if (invalid_discount) {
            $('#discount_code').addClass('errorInput');
        }

        var discountPercent = $('#discount_percent').val();
        if (discountPercent) {
            this.discountType = 'percent';
            this.discountAmount = Number(discountPercent) * -1;
        } else {
            this.discountType = _this.discountAmount = null;
        }
    
        this.discountAmount = 0;
        this.discountType= null;
        this.updateDetails(packageid);
*/
    },

    getYearly: function () {
        var pay_yearly = 0;
        if ($('#yearly').length) {
            pay_yearly = this.frequencyBox.find('input[name=pay_yearly]:checked').val();
        } else {
            pay_yearly = Dayhome.billingPage.payment_frequency == 12 ? 1 : 0;
        }
        return pay_yearly;
    },

	/*
    Update the package details information box
    */
    updateDetails: function (packageid) {
    	var self = this;
    	var period_total = 0;
        var base_package = Dayhome.billingPage.existing;
        if (packageid && Dayhome.billingPage.packages[packageid]) {
            base_package = Dayhome.billingPage.packages[packageid];
        }

        $.each(this.newLimits, function (type, element) {
            var text = base_package[type] === null ? 'Unlimited' : base_package[type];
            element.text(text);
        });

        // Update the plan for CC
        this.plan.val(base_package.plan);
        
        // Update the sidebar numbers and text
        var period_total = Number(base_package.price),
        totalBoxBase = $('#total_box_base'),
        totalBoxTotal = $('#total_box_total'),
        totalBoxRate = $('#total_box_rate');
        totalBoxFeatures = $('#total_box_features');
        totalBoxEvents = $('#total_box_events');
        totalAfterCoupon= $('#total_after_coupon');

        payment_frequency=1;
        var value_total = 0;

        //Update the package base rate and name
        totalBoxRate.find('span.amount').text(base_package.price);
        $('#package_name').text(base_package.name);
        var frequency_text = base_package.subscription == "yr" ? 'You pay (per Year)' : 'You pay (per Month)';
        totalBoxRate.find('strong.title').text(frequency_text);

        //apply discount and update package rate
        if (this.discountAmount!=0){
            totalAfterCoupon.show();
            if(this.discountType=="percent"){
                totalAfterCoupon.find('span#coupon_amount').text(this.discountAmount+"%");
                totalAfterCoupon.find('span.amount').text((base_package.price-(base_package.price*this.discountAmount/100.00)).toFixed(2));
            } else {
                totalAfterCoupon.find('span#coupon_amount').text("$"+this.discountAmount);
                totalAfterCoupon.find('span.amount').text(base_package.price-this.discountAmount);
            }
        }


        //figure out what the base is worth
        if(base_package.subscription=="yr"){
        	totalBoxBase.find('span.amount').text(base_package.price);
        	value_total+=base_package.price;
        } else {
        	var val = Math.round(5*(base_package.day_homes>0?base_package.day_homes:500),2);
        	totalBoxBase.find('span.amount').text((base_package.day_homes>0?"":"> ")+val);
        	value_total+=val;
        }

        //figure out what the featuring is worth
        totalBoxFeatures.find('span.amount').text((5)*base_package.free_features);
        value_total+=(5)*base_package.free_features;

        //figure out what the events are worth
        totalBoxEvents.find('span.amount').text((20)*base_package.events);
        value_total+=(20)*base_package.events;

        //Update the value
        totalBoxTotal.find('span.amount').text(value_total);

        //Now update the blurbs
        var feature_frequency = "once a year.";
        if(base_package.subscription!="yr") {
        	if(base_package.free_features==1){
        		feature_frequency = "once a month."
        	} else {
        		feature_frequency = base_package.free_features + " times a month."
        	}
        }
        $('#feature_blurb').find('span.feature_frequency').text(feature_frequency)
        if(base_package.staff>0){
        	$('#staff_blurb').find('span.staff_count').text(base_package.staff)
        	$('#staff_blurb').show();
        }else {
        	$('#staff_blurb').hide();
        }
        if(base_package.day_homes>1){
        	$('#dayhome_blurb').find('span.dayhome_count').text(base_package.day_homes)
        	$('#dayhome_blurb').show();
        } else if (base_package.day_homes<0){
        	$('#dayhome_blurb').find('span.dayhome_count').text("unlimited")
        	$('#dayhome_blurb').show();
        }else {
        	$('#dayhome_blurb').hide();
        }    
        if(base_package.locales>1){
        	$('#community_blurb').find('span.community_count').text(base_package.locales)
        	$('#community_blurb').show();
        } else if (base_package.locales<0) {
        	$('#community_blurb').find('span.community_count').text("unlimited")
        	$('#community_blurb').show();
        }else {
        	$('#community_blurb').hide();
        }    
        if(base_package.events>0){
        	$('#event_blurb').show();
        }else {
        	$('#event_blurb').hide();
        }   

        //$('#total_box_total .amount').text(this.currency.round(period_total));
        return value_total;
    },
    /*
    Apply the discounts to the amount provided.  paymentFrequency controls the yearly 
    discount application. We give 10% discounts to yearly payment intervals.

    Applies the yearly discount as well as any selected discounts.
    */
    applyDiscount: function (amount, paymentFrequency) {
        if (paymentFrequency == 12) {
            amount = (amount * 12) * 0.9;
        }
        if (this.discountType == 'percent') {
            amount = amount * (100 - this.discountAmount) / 100;
        }
        return amount;
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
            },
            highlight = $('#day_home_highlight').val()
            highlightMax = $('#day_home_highlight').attr('maxLength');
            ;

        // if doing a downgrade, don't validate these fields as they are not required
        if ($('#credit-card-section').is(':hidden') || $('#card_number').is(':hidden')) {
            delete validators.CREDIT_CARD_NUMBER;
            delete validators.CVV;
        }

        var agreed = true;
        if ($('#ack').length) {
            agreed = $('#ack').is(':checked');
        }
        if (!agreed) {
            alert('You must agree to the privacy policy and terms of use.');
            $('#ack').focus();
        }

        if (!agreed || !build_validator(validators)(this)) {
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
        self.payNowButton.val('Processing…').prop('disabled', true);

        if (!$('#credit-card-section').is(':hidden') && ($('#card_number').length>0 && !$('#card_number').is(':hidden'))) {
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
        $('#pay-now-button').val('Pay Now').prop('disabled', false);

        $('#stripe_error').text(response.error.message);        
        $('input[type=submit]').attr('disabled',false);
      }
    }


})
