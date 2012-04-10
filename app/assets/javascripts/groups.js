(function ($) {
    'use strict'

    var metaCheckbox = function (meta, subord) {
            this.meta = $(meta)
            this.subord = $(subord)
            this.__init__()
        }

    metaCheckbox.prototype.__init__ = function () {
            var thus = this

            // Click this -> propogate to subordinates
            this.meta.click(function () {
                thus.subord.each(function () {
                    $(this).prop('checked', thus.meta.prop('checked'))
                })
            })

            // Click subordinate -> propogate to this
            this.subord.click(function () {
                thus.updateMeta()
            })

            // Update meta checkbox initially
            this.updateMeta()
        }

    metaCheckbox.prototype.updateMeta = function () {
        var values = this.subord.map(function () {
                return $(this).prop('checked')
            }),
            result = (_.reduce(values, function (a, b) {
                return a === null ? b : (a === b ? a : undefined)
            }, null))

        switch (result) {
        case undefined:
            this.meta.prop('indeterminate', true)
            break
        default:
            this.meta.prop('checked', result)
            this.meta.prop('indeterminate', false)
            break
        }
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

            new metaCheckbox($(this), $('table.body input[data-name="'+name+'"]'))
        })
    })
})(jQuery)
