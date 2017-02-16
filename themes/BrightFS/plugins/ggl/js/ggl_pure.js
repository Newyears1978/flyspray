var ggl_dd = document.querySelectorAll(".dropdown .button, .dropdown button");
for (var i = 0; i < ggl_dd.length; i++) {
	ggl_dd[i].addEventListener("click", function() {
		if ( this.querySelector('span.toggle').classList.contains('.active') )
        {
			this.style.display = '';
        }
	    //console.log("clicked");
	});
}

document.onclick = function(e){
	if (e.target.id != e.target.getAttribute('class'))
    {
        e.target.display = 'none';
		// className = 'active';
		// if (e.classList)
		// 	e.classList.remove(className);
		// else
		// 	e.className = e.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ');
    }
};

/*
$(document).ready(function() {
    // Toggle the dropdown menu's
    $(".dropdown .button, .dropdown button").click(function () {
        if (!$(this).find('span.toggle').hasClass('active')) {
            $('.dropdown-slider').slideUp();
            $('span.toggle').removeClass('active');
        }

        // open selected dropown
        $(this).parent().find('.dropdown-slider').slideToggle('fast');
        $(this).find('span.toggle').toggleClass('active');

        return false;
    });
});
// Close open dropdown slider by clicking elsewhwere on page
$(document).bind('click', function (e) {
    if (e.target.id != $('.dropdown').attr('class')) {
        $('.dropdown-slider').slideUp();
        $('span.toggle').removeClass('active');
    }
});
*/