
$(document).ready(function() {
  $("input.editable_list").each(function(i, input) {
    $('#' + input.id).tagEditor({
      tagsBeforeField: true
    });
  });
});
