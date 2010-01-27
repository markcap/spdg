$(document).ready(function() {
	if (document.referrer.indexOf('spdg') == -1 || document.referrer.indexOf('spdg') == null) {
		$(".logo-top").hide();
		$(".slogan-top").hide();
		$(".slogan-bottom").hide();
		$(".logo-top").fadeIn(1500)
		$(".slogan-top").delay(1200).fadeIn(600)
		$(".slogan-bottom").delay(1900).fadeIn(600)
	}

	
	$("#login_form").hide();
	$(".login_link").click(function()
	 		{
				$("#login_form").fadeIn(500);
				$("#login_start").hide();
	 		});
});

