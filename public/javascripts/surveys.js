function remove_fields(link) {
  jQuery(link).prev("input[type=hidden]").val("1");
  jQuery(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  jQuery("#add_question_here").append(content.replace(regexp, new_id));
}

jQuery(document).ready(function() {
	jQuery("#templates").hide();
	jQuery(".template_link").click(function()
		{
			jQuery("#templates").fadeIn(500);
			jQuery(".template_link").hide();
			return false;
		});
});