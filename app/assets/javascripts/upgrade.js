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




Dayhome.upgradePage.Upgrade = Class.extend({
	defaults: {
        form: '#upgrade-form',
        update_triggers: '#staff, #locales',
        keys: {
            staff: 'staff',
            locales: 'locales'
        }
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
        //this.country = $('#p_country');
        //this.is_mobile = $('#is_mobile');

        //this.frequencyBox = $('#green_box');
    },

	bindEvents: function () {
        var self = this;

        $(this.options.form).bind('submit', this.handleForm);

        // List of all the things which can affect pricing 
/*        
        $(this.options.update_triggers).bind('change', function () {
            self.update();
        });
*/
        $('#choose-package').bind('change', function (event) {
            self.checkPackageSwitch();
        });

    },
    
    get_additional_value: function (type) {
        return parseInt($('#' + type + ':enabled').val(), 10) || 0;
    },
    
    checkPackageSwitch: function (event) {
        var packageid = Number(this.packageInput.val());
        var self = this;
        self.update();        
    },

    update: function () {
        
        var packageid = this.packageInput.val();

        //update the details on the page.
        var period_total = this.updateDetails(packageid);

        if (period_total.toFixed(2) - Dayhome.upgradePage.payment_amount.toFixed(2) <= 0) {
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
*/
        this.discountAmount = 0;
        this.discountType= null;
        this.updateDetails(packageid);

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
        if (totalBoxBase.css('display') == 'none') {
            period_total = Number($('#current_plan .amount').text());
        }

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

        // update the Upgrade Details amounts + pricing.
        var selectedExtraCount = 0;
        $.each(this.costElements, function (type, element) {
            var extra = self.get_additional_value(type);
            if (extra) {
                var extra_cost = parseFloat(Dayhome.upgradePage.additional_cost[type](extra));

                //discount the addons
                extra_cost = self.applyDiscount(extra_cost, payment_frequency);
                period_total += extra_cost || 0;

                element.show()
					.find(self.options.numberClass).text(extra + ' ')
					.end()
					.find(self.options.amountClass).text(self.currency.round(extra_cost));
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
    }


})

$(function () {
    var upgrader = new Dayhome.upgradePage.Upgrade();

    // Just eat every event possible.
    $('.pricingTable a').bind('click', function (e) {
        e.preventDefault();
    });

    // Allow clicking the buttons to modify the input and update the package info.
    $('.pricingTable .enabled').bind('click', function (event) {
        var $this = $(this);
        var packageId = $this.attr('rel');

        $('table.pricingTable th, table.pricingTable td').removeClass('selected_package');
        var rowIndex = $this.prevAll().length + 1;
        $('table.pricingTable tr td:nth-child(' + rowIndex + ')').addClass('selected_package');
        $('table.pricingTable tr th:nth-child(' + rowIndex + ')').addClass('selected_package');

        if(!$this.hasClass('current_package')) {
            $('table.pricingTable td:not(.current_package) div.button_green a').html('Select');
            $('table.pricingTable th:nth-child(' + rowIndex + ') div.button_green a, table.pricingTable td:nth-child(' + rowIndex + ') div.button_green a').html('Selected');
        }
        $('#choose-package').val(packageId).trigger('change');
/*
        $('#total_box_base').show();
        $('#upgrade-form').show();

        try {
            $.scrollTo($('#addon-header').position().top - ($(window).height() / 2),
                { speed: 'slow'}
            );
        } catch(err) {}
*/
    }).hover(
        function () {
            $(this).css('cursor', 'pointer');
            var packageClass = this.className.match(/package_\d+/);
            $('td.' + packageClass).addClass('over_package');
        },
        function () {
            var packageClass = this.className.match(/package_\d+/);
            $('td.' + packageClass).removeClass('over_package');
        }
    );
});