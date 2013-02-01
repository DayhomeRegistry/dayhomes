function integersonly(e,t){
  var n=jQuery.event.fix(t||window.event),r=n.which,i=String.fromCharCode(r);
  return r===undefined?!0:isPrintableKey(n)?"0123456789".indexOf(i)>-1?!0:!1:!0;
}
window.numbersonly2=integersonly;

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

        $('#total_box_base').show();
        $('#upgrade-form').show();
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
    var packageid = Dayhome.upgradePage.existing.id;
    if (packageid) {
      $('table.pricingTable .package_' + packageid).addClass('selected_package');
      $('table.pricingTable .package_' + packageid + ' a.button.green').html('<span>Free Trial</span>');
    }
});