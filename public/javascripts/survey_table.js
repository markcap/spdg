jQuery(document).ready(function() {
	//surveys data table
	jQuery('#surveys_table').dataTable( {
	  "aaSorting": [[2,'desc']],
		"aoColumns": [ 
			{ "sType": "html" },
			{ "sType": "html" },
			{ "sWidth": "14%" },
			{ "sType": "numeric",
			 	"sClass" : "center" }
			],
		"iDisplayLength": 25
	});
});