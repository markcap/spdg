$(document).ready(function() {
	$("#logo").hide();
	$("#logo").fadeIn(2000);
	$("#login_form").hide();
	
	$(".login_link").click(function()
	 		{
				$("#login_form").fadeIn(500);
				$("#login_start").hide();
	 		});
});

