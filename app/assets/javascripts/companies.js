# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function() {
  $("#companies th a, #companies .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#companies_search input").keyup(function() {
    $.get($("#companies_search").attr("action"), $("#companies_search").serialize(), null, "script");
    return false;
  });
});
