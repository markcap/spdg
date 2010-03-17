jQuery(document).ready(function() {
	if (document.referrer.indexOf('spdg') == -1 || document.referrer.indexOf('spdg') == null) {
		jQuery(".logo-top").hide();
		jQuery(".slogan-top").hide();
		jQuery(".slogan-bottom").hide();		
		jQuery(".logo-top").delay(0).fadeIn(1500);
		jQuery(".slogan-top").delay(1200).fadeIn(600);
		jQuery(".slogan-bottom").delay(1900).fadeIn(600);
	}

	
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
});

