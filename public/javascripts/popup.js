//Submit a form with ajax function:
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
	
	//initialize Shadowbox. Use rel="shadowbox" to open with it
	Shadowbox.init();
	
	//Use this to open any div with a shadowbox
	// $(".shadowbox_div").click(function() {
	//   Shadowbox.open({
	//       content:    $(this).html(),
	//       player:			"html",
	//       title:      "Welcome"
	//   });
	// });
	// 

	//Submit a form with ajax here. Example: 
	//$("#new_home").submitWithAjax();
	
});