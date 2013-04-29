
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
