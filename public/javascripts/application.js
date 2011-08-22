// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	$("body").bind("click", function (e) {
		$('a.menu').parent("li").removeClass("open");
	});

	$("a.menu").click(function (e) {
		var $li = $(this).parent("li").toggleClass('open');
		return false;
	});
});