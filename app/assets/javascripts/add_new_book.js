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
            },
            complete: function () {
                setTimeout(function () {
                    $(".save-form").click(postMyForm)
                    $('#tags').tagsinput()
                    $("#search_by_title").click(searchGoogleBooksByTitle)
                    $("#search_by_isbn").click(searchGoogleBooksByISBN)
                    disableCheckboxes();
                    $("#book_title").keyup(enableSearchByTitleCheckbox);
                    $("#book_isbn").keyup(enableSearchByIsbnCheckbox);
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
    hideAlerts();
    var image_url = $("#book_image").attr("src");
    var valuesToSubmit = $("#new_book").serialize() + "&image_url=" + image_url;

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
            displayErrors(errors);
        }
    })
}


var searchGoogleBooksByISBN = function () {
    if ($(this).is(":checked")) {
        $.ajax({
            url: '/books/get_by_isbn/' + $('#book_isbn').val(),
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (searchedBook) {
                displaySearchedBookValues(searchedBook);
            },
            error: function(error) {
                $(".isbn-errors").text(error.responseText)
                $("#search_by_isbn").attr('checked', false);
                $(".form-control").val("")
                disableCheckboxes()
            }

        })
    }
}

var searchGoogleBooksByTitle = function () {
    if ($(this).is(":checked")) {
        $.ajax({
            url: '/books/get_by_title/' + $('#book_title').val(),
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (searchedBook) {
                displaySearchedBookValues(searchedBook);
            }
        })
    }
}

var displaySearchedBookValues = function (searchedBook) {
    var searchedBookJson = JSON.parse(searchedBook)
    $('#book_title').val(searchedBookJson.possible_book.title)
    $('#book_author').val(searchedBookJson.possible_book.author)
    $('#book_description').val(searchedBookJson.possible_book.description)
    $('#book_isbn').val(searchedBookJson.possible_book.isbn)
    $("#book_image").attr("src", searchedBookJson.image_link)
    $("#errors").text('')
    $("#search_by_title").attr('checked', false);
    $("#search_by_isbn").attr('checked', false);
}

var disableCheckboxes = function () {
    $("#search_by_title").attr('disabled', true);
    $("#search_by_isbn").attr('disabled', true);
}

var enableSearchByTitleCheckbox = function () {
    if ($(this).val() != '') {
        $("#search_by_title").attr('disabled', false);
    }
    else {
        $("#search_by_title").attr('disabled', true);
    }
}

var enableSearchByIsbnCheckbox = function () {
    if ($(this).val() != '') {
        $("#search_by_isbn").attr('disabled', false);
    }
    else {
        $("#search_by_isbn").attr('disabled', true);
    }
}

var displayErrors = function (errors) {
    var errorJson = JSON.parse(errors.responseText);
    for (var key in errorJson) {
        $("." + key + "-errors").text(errorJson[key]);
    }
}

var hideAlerts = function () {
    $(".alert").hide();
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
        $("#book_image").attr("src", "")
        $(".alert-success").show();
    }
}

$(document).ready(function () {
    getNewBookForm();
})

$(document).on('page:load', function () {
    getNewBookForm();
});

