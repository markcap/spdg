function remove_fields(link) {
  jQuery(link).prev("input[type=hidden]").val("1");
  jQuery(link).closest(".fields").hide();
	//this is for renumbering. you need to remove the position class from deleted questions because they're actually just hidden and are still in the form.
	jQuery(link).parent().find(".position").removeClass('position');
}

function add_fields(link, association, content) {
	last_number = jQuery(".position:last").val();
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  jQuery("#add_question_here").append(content.replace(regexp, new_id));
  // add next position number
	if (last_number == null)
		jQuery(".position:last").val(1);
	else
		jQuery(".position:last").val(parseInt(last_number) + 1);
}

jQuery(document).ready(function() {
	jQuery("#templates").hide();
	jQuery(".template_link").click(function()
		{
			jQuery("#templates").fadeIn(500);
			jQuery(".template_link").hide();
			return false;
		});
		
	jQuery(".close_templates").click(function()
		{
			jQuery("#templates").hide();
			jQuery(".template_link").show();
			return false;
		});
			
	jQuery(".renumber").click(function()
		{
			jQuery('.position').each(function(index) {
				if (index == 0){
					jQuery(this).val("1");
					last_number = 1;
				}
				else {
					jQuery(this).val(parseInt(last_number) + 1)
			    last_number = jQuery(this).val();
				}	
			 });
			
		});
});