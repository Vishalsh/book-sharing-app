var getNewBookForm = function () {

    $("#add_new_book").on('click', function (e) {
        $("#addBookModal").remove();
        $.ajax({

            url: '/books/new',
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $(data).modal('show');
                setTimeout(function () {
                    $("#search_button").on('click', getBookInformation)
                }, 500);
            },
            complete: function (data) {
                setTimeout(function () {
                    $(".save-form").on('click', postMyForm)
                }, 500);
            }
        })
    });
}


var postMyForm = function (e) {
    e.preventDefault();
    var currentSaveButton = $(this)
    $(".alert-info").show();
    hideErrors();
    var valuesToSubmit = $("#new_book").serialize();

    $.ajax({
        url: '/books/create',
        type: 'POST',
        data: valuesToSubmit,
        dataType: 'json',
        success: function () {
            $(".alert-danger").hide();
            $(".alert-info").hide();
            checkForAddAnotherBook(currentSaveButton);
        },

        error: function (errors) {
            $(".alert-info").hide();
            $(".alert-success").hide();
            $(".alert-danger").show();
            displayErrors(errors)
        }

    })
}


var displayErrors = function (errors) {
    var errorJson = JSON.parse(errors.responseText);
    for (var key in errorJson) {
        $("." + key + "-errors").text(errorJson[key]);
    }
}

var hideErrors = function () {
    $(".errors").text('');
}

var checkForAddAnotherBook = function (currentSaveButton) {
    if (currentSaveButton.attr('id') == 'save_form') {
        window.location.replace("/books/own_books");
    }
    else {
        $(".form-control").val("")
        $(".alert-success").show();
    }
}

var getBookInformation = function () {

    $.ajax({
        url: '/books/get_by_isbn/:' + $('#book_isbn').val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html'
    }).success(function () {
            $('#title').val('title')
            $('#author').val('author')
            $('#description').val('description')
        });
}


$(document).ready(function () {
    getNewBookForm();
})

$(document).on('page:load', function () {
    getNewBookForm();
});

