(function ($) {
    'use strict'

    var timeout = 1000 * 10

    function ping(uri, callback) {
        $.ajax(uri, {
            success: function (data) {
                if (data.waiting) {
                    window.setTimeout(function () {
                        ping(uri, callback)
                    }, timeout)
                } else {
                    callback(data.uri)
                }
            },
        error: function () {
            alert('Error code 002.')
        }
        })
    }

    $(function () {
        $('.modal')
            .modal({
                backdrop: 'static',
                keyboard: false,
                show: false
            })
            .hide()

        $('#export_to_gdocs').click(function () {
            var uri = $(this).data('uri')
            $(this).attr('disabled', true)
            $('#export_to_gdocs_dialog').modal('show')

            $.ajax(uri, {
                type: 'POST',
                success: function (data) {
                    ping(data['ping'], function (u) {
                        document.location.href = u
                    })
                },
                error: function () {
                    alert('Error code 001.')
                }
            })
        })
    })
})(jQuery)
