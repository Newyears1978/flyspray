jQuery(document).ready(function() {
    // Toggle the dropdown menu's
    jQuery(".dropdown .button, .dropdown button").click(function () {
        if (!jQuery(this).find('span.toggle').hasClass('active')) {
            jQuery('.dropdown-slider').slideUp();
            jQuery('span.toggle').removeClass('active');
        }

        // open selected dropown
        jQuery(this).parent().find('.dropdown-slider').slideToggle('fast');
        jQuery(this).find('span.toggle').toggleClass('active');

        return false;
    });
});
// Close open dropdown slider by clicking elsewhwere on page
jQuery(document).bind('click', function (e) {
    if (e.target.id != jQuery('.dropdown').attr('class')) {
        jQuery('.dropdown-slider').slideUp();
        jQuery('span.toggle').removeClass('active');
    }
});
