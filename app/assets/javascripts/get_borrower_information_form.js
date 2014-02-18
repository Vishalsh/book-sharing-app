var getBorrowerForm = function () {

    $("#add_new_borrower").on('click', function (e) {

        $("#borrower_info_modal").remove();

        $.ajax({

            url: '/borrowers/new',
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $(data).modal('show');
            },

            complete: function () {
                setTimeout(function () {
                    $("#save_form").on('click', postBorrowerForm)
                    $("#date_of_borrowing").datepicker({
                        format: 'dd/mm/yyyy'
                    });
                }, 500)
            }
        })
    })
}

var postBorrowerForm = function(e) {
    e.preventDefault();
    var valuesToSubmit = $("#borrower_info_form").serialize() + "&book_id=" + $(".book-id").val();
    hideAlerts();
    hideErrors();
    $(".alert-info").show();
    $.ajax({
        url: '/borrowers/create',
        type: 'POST',
        data: valuesToSubmit,
        dataType: 'json',
        success: function () {
            $(".alert-danger").hide();
            $(".alert-info").hide();
            $(".alert-success").show();
            $(".form-control").val("");
            history.go(0);
        },

        error: function (errors) {
           $(".alert-info").hide();
            $(".alert-success").hide();
            $(".alert-danger").show();
            displayErrors(errors)
        }
    })
}


//var hideErrors = function () {
//    $(".errors").text('');
//}
//
//var hideAlerts = function() {
//    $(".alert").hide();
//}
//
//var displayErrors = function (errors) {
//    var errorJson = JSON.parse(errors.responseText);
//    for (var key in errorJson) {
//        $("." + key + "-errors").text(errorJson[key]);
//    }
//}

$(document).ready(getBorrowerForm);
$(document).on('page:load', getBorrowerForm);
