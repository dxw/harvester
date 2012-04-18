
$(document).ready(function() {
    $("input.editable_list").each(function(i, input) {
        $(input).tagEditor({
            tagsBeforeField: true,
            hiddenField: $(input).data('for')
        })
    })
})
