//Rails 2.3.11 security fix
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

jQuery(document).ready(function() {
	
	if (document.referrer.indexOf('spdg') == -1 || document.referrer.indexOf('spdg') == null) {
		// jQuery(".logo-top").hide();
		jQuery(".slogan-top").hide();
		jQuery(".slogan-bottom").hide();		
		// jQuery(".logo-top").delay(0).fadeIn(1500);
		jQuery(".slogan-top").delay(600).fadeIn(600);
		jQuery(".slogan-bottom").delay(1300).fadeIn(600);
	}

	jQuery('.search_help_popup').click(function() {
    newwindow=window.open('http://spdgkansas.net/help_form','strat_window','height=500,width=500');
  	if (window.focus) {newwindow.focus()}
  	return false;
  });
  
	jQuery("#login_form").hide();
	jQuery(".login_link").click(function()
	 		{
				jQuery("#login_form").fadeIn(500);
				jQuery("#login_start").hide();
	 		});
	
	jQuery(".add_contact_link").click(function()
		{
			jQuery("#add_contact_form").fadeIn(500);
			jQuery(".add_contact_link").hide();
			return false;
		});
		
	jQuery(".add_user_link").click(function()
		{
			jQuery("#add_user_form").fadeIn(500);
			jQuery(".add_user_link").hide();
			return false;
		});
		
	jQuery("#attachment_form").hide();
	jQuery(".add_attachment_link").click(function()
		{
			jQuery("#attachment_form").fadeIn(500);
			jQuery(".add_attachment_link").hide();
			return false;
		});
	
	jQuery("#add_header_form").hide();
	jQuery(".add_header_link").click(function()
		{
			jQuery("#add_header_form").fadeIn(500);
			jQuery(".add_header_link").hide();
			return false;
		});
		
	jQuery(".add_resource_form").hide();
	jQuery(".add_resource_link").click(function()
		{
			number = jQuery(this).attr('number');
			jQuery("#add_resource_form_" + number).fadeIn(500);
			return false;
		});
		
	jQuery(".add_goal_link").click(function()
		{
			jQuery("#add_goal_form").fadeIn(500);
			jQuery(".add_goal_link").hide();
			return false;
		});

});

