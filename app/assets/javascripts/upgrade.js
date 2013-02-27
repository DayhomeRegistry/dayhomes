/* Simple JavaScript Inheritance
 * By John Resig http://ejohn.org/
 * MIT Licensed.
 */
// Inspired by base2 and Prototype
(function(){
  var initializing = false, fnTest = /xyz/.test(function(){xyz;}) ? /\b_super\b/ : /.*/;
  // The base Class implementation (does nothing)
  this.Class = function(){};
  
  // Create a new Class that inherits from this class
  Class.extend = function(prop) {
    var _super = this.prototype;
    
    // Instantiate a base class (but only create the instance,
    // don't run the init constructor)
    initializing = true;
    var prototype = new this();
    initializing = false;
    
    // Copy the properties over onto the new prototype
    for (var name in prop) {
      // Check if we're overwriting an existing function
      prototype[name] = typeof prop[name] == "function" && 
        typeof _super[name] == "function" && fnTest.test(prop[name]) ?
        (function(name, fn){
          return function() {
            var tmp = this._super;
            
            // Add a new ._super() method that is the same method
            // but on the super-class
            this._super = _super[name];
            
            // The method only need to be bound temporarily, so we
            // remove it when we're done executing
            var ret = fn.apply(this, arguments);        
            this._super = tmp;
            
            return ret;
          };
        })(name, prop[name]) :
        prop[name];
    }
    // The dummy class constructor
    function Class() {
      // All construction is actually done in the init method
      if ( !initializing && this.init )
        this.init.apply(this, arguments);
    }
    
    // Populate our constructed prototype object
    Class.prototype = prototype;
    
    // Enforce the constructor to be what we expect
    Class.prototype.constructor = Class;

    // And make this class extendable
    Class.extend = arguments.callee;
    
    return Class;
  };
})();
function ensure_nonempty_field(e, t, n) {
    return !e[t].disabled && (e[t].val() === "") ? (alert(n), e[t].focus(), !1) : !0
}
function build_validator(e) {
    return function (t) {
        for (var n in e) {
            if (t[n] && !ensure_nonempty_field(t, n, e[n])) 
                return !1;
        }
        return !0
    }
}

Dayhome.upgradePage.Upgrade = Class.extend({
	defaults: {
        form: '#upgrade-form',
        update_triggers: '#staff, #locales',
        keys: {
            staff: 'staff',
            locales: 'locales'
        },        
        numberClass: '.num',
        amountClass: '.amount'
    },
    //elements used to display the currently selected pricing info
    costElements: {},

    //containers for the inputs.
    inputContainers: {},

    //inputs to read data from.
    inputs: {},

    //limits for the new package
    newLimits: {},
    
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
            self.update();
        });

        $('#choose-package').bind('change', function (event) {
            self.checkPackageSwitch();
        });

    },
    
    get_additional_value: function (type) {
        return parseInt($('#' + type + ':enabled').val(), 10) || 0;
    },
    
    isCurrentPackageFree: function () {
        var base_package = Dayhome.upgradePage.existing;
        var packageid = Number(this.packageInput.val());
        if (packageid && Dayhome.upgradePage.packages[packageid]) {
            base_package = Dayhome.upgradePage.packages[packageid];
        }
        return base_package.price == 0;
    },
    checkPackageSwitch: function (event) {
        var packageid = Number(this.packageInput.val());
        var self = this;
        if (this.isCurrentPackageFree())
        {
            $('#credit-card-section').hide();
            this.payNowButton.val('Signup Now');
        } else {
            $('#credit-card-section').show();
            this.payNowButton.val('Pay Now');
        }
        self.update();        
    },

    update: function () {
        
        var packageid = this.packageInput.val();

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
            pay_yearly = Dayhome.upgradePage.payment_frequency == 12 ? 1 : 0;
        }
        return pay_yearly;
    },

	/*
    Update the package details information box
    */
    updateDetails: function (packageid) {
    	var self = this;
    	var period_total = 0;
        var base_package = Dayhome.upgradePage.existing;
        if (packageid && Dayhome.upgradePage.packages[packageid]) {
            base_package = Dayhome.upgradePage.packages[packageid];
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
        totalBoxTotal = $('#total_box_total');

        //adjust payment_frequency based in input selection.
        var payment_frequency = this.getYearly() == '1' ? 12 : 1;

        // update the payment rate text
        var frequency_text = payment_frequency == 12 ? 'Yearly Rate' : 'Monthly Rate';
        totalBoxTotal.find('strong.title').text(frequency_text);

        //apply yearly and discount percents if they are available.
        period_total = this.applyDiscount(period_total, payment_frequency);
        var package_price = period_total;

        // If there is no new package use the existing price to calculate the period_total.
        //if (totalBoxBase.css('display') == 'none') {
        //    period_total = Number($('#current_plan .amount').text());
        //}

        //Hide + disable any addons that are blocked by the base package
        var visibleAddons = 0;
        $.each(this.inputContainers, function (type, element) {
            if (Number(base_package['block_' + type + '_addon']) === 1 || base_package[type] === null) {
            element.hide();
            self.inputs[type].prop('disabled', true).val('');
            } else {
            element.show();
            self.inputs[type].prop('disabled', false);
            }
            if (element.length && element.css('display') != 'none') {
            visibleAddons++;
            }
        });
        
        // figure out what the cost of the current staff and locales they have is going to be
        /*var current_staff = $('#total_box_cur_staff');
        var current_locales = $('#total_box_cur_locales');
        var extra_staff = Math.max.apply(null,[Dayhome.upgradePage.current.staff-base_package.staff,0])
        var extra_locales = Math.max.apply(null,[Dayhome.upgradePage.current.locales-base_package.locales,0])
        var extra_staff_cost = parseFloat(Dayhome.upgradePage.additional_cost["staff"](extra_staff));
        var extra_locales_cost = parseFloat(Dayhome.upgradePage.additional_cost["locales"](extra_locales));

        current_staff.show()
          .find(self.options.numberClass).text(extra_staff + ' ')
          .end()
          .find(self.options.amountClass).text(extra_staff_cost);
        current_locales.show()
          .find(self.options.numberClass).text(extra_locales + ' ')
          .end()
          .find(self.options.amountClass).text(extra_locales_cost);
        */
        // update the Upgrade Details amounts + pricing.
        var selectedExtraCount = 0;
        $.each(this.costElements, function (type, element) {
            var extra = self.get_additional_value(type);
            if (extra) {
                var extra_cost = parseFloat(Dayhome.upgradePage.additional_cost[type](extra));

                //discount the addons
                extra_cost = self.applyDiscount(extra_cost, payment_frequency);
                period_total += extra_cost || 0;

                //.find(self.options.amountClass).text(self.currency.round(extra_cost));
                element.show()
                  .find(self.options.numberClass).text(extra + ' ')
                  .end()
                  .find(self.options.amountClass).text(extra_cost);
                selectedExtraCount++;
            } else {
                element.hide();
            }
        });
        //totalBoxBase.find('span.amount').text(this.currency.round(package_price));
        totalBoxBase.find('span.amount').text(package_price);

        if (selectedExtraCount === 0 && totalBoxBase.css('display') === 'none') {
            $('#total_box').hide();
        } else {
            $('#total_box').show();
        }

        //$('#total_box_total .amount').text(this.currency.round(period_total));
        $('#total_box_total .amount').text(period_total);
        $('#package_name').text(base_package.name);
        return period_total;
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
            };

        // if doing a downgrade, don't validate these fields as they are not required
        if ($('#credit-card-section').is(':hidden')) {
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
        self.payNowButton.val('Loading…').prop('disabled', true);

        if (!self.isCurrentPackageFree()) {
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
        $('form')[1].submit();
      } else {
        // Enable the button.
        $('#pay-now-button').val('Pay Now').prop('disabled', false);

        $('#stripe_error').text(response.error.message);        
        $('input[type=submit]').attr('disabled',false);
      }
    }


})
