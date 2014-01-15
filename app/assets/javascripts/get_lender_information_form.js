var getLenderForm = function () {
    $("#add_new_lender").on('click', function (e) {

        $("#lender_info_modal").remove();

        $.ajax({

            url: '/lenders/new',
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $(data).modal('show');
            },

            complete: function () {
                setTimeout(function () {
                    $("#save_form").on('click', postLenderForm)
                    $("#lender_date_of_lending").datepicker({
                        format: 'dd/mm/yyyy'
                    });
                }, 500)
            }
        })
    })
}


var postLenderForm = function(e) {
    e.preventDefault();
    var valuesToSubmit = $("#new_lender").serialize();
    hideAlerts();
    hideErrors();
    $(".alert-info").show();
    $.ajax({
        url: '/lenders/create',
        type: 'POST',
        data: valuesToSubmit,
        dataType: 'json',
        success: function () {
            $(".alert-danger").hide();
            $(".alert-info").hide();
            $(".alert-success").show();
            $(".form-control").val("");
        },

        error: function (errors) {
           $(".alert-info").hide();
            $(".alert-success").hide();
            $(".alert-danger").show();
            displayErrors(errors)
        }

    })
}

var hideErrors = function () {
    $(".errors").text('');
}

var hideAlerts = function() {
    $(".alert").hide();
}

var displayErrors = function (errors) {
    var errorJson = JSON.parse(errors.responseText);
    for (var key in errorJson) {
        $("." + key + "-errors").text(errorJson[key]);
    }
}

$(document).ready(getLenderForm);