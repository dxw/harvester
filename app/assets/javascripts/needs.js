
$(document).ready(function() {
  $("input.editable_list").each(function(i, input) {
    $('#' + input.id).tagEditor({
      confirmRemoval: true,
      tagsBeforeField: true
    });
  });
});
