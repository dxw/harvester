(function ($) {
    'use strict'

    var metaCheckbox = function (meta, subord) {
        meta = $(meta)
        subord = $(subord)

        // Click this -> propogate to subordinates
        meta.click(function () {
            subord.each(function () {
                $(this).prop('checked', meta.prop('checked'))
            })
        })

        // Click subordinate -> propogate to this
        subord.click(function () {
            var myValue = $(this).prop('checked'),
                values = subord.map(function () {
                    return $(this).prop('checked')
                })

            if (_.all(values, function (a) { return a === myValue })) {
                meta.prop('checked', myValue)
                meta.prop('indeterminate', false)
            } else {
                meta.prop('indeterminate', true)
            }
        })

        // Update meta checkbox initially
        //TODO
    }

    $(function () {
        // Resize
        $(window).resize(function () {
            $('iframe#content').height($(window).height() - 250)
        })
        $(window).trigger('resize')

        // Meta checkboxes
        $('body.groups.edit table.meta input').each(function () {
            var name = $(this).data('name')

            metaCheckbox($(this), $('table.body input[data-name="'+name+'"]'))
        })
    })
})(jQuery)
