

$(function () {
    var biller = new Dayhome.billingPage.Billing();

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

        $('#total_box_base').show();
        $('#billing-form').show();
/*
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
    //select the current package
    var packageid = Dayhome.billingPage.current.id;
    if (packageid) {
        $('table.pricingTable .package_' + packageid).addClass('current_package');
        $('table.pricingTable .package_' + packageid + ' .button span').html('Your Plan');
    } else {
        //Just select the first one
        $('table.pricingTable th')[1].click();
    }
    
    //highlight the selected package, for when a POST fails.
    var packageid = Dayhome.billingPage.current.id;
    if (packageid) {
      $('table.pricingTable .package_' + packageid)
            .addClass('selected_package')
            .find('.button.medium')
            .trigger('click');
    }


});