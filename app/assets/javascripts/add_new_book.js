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
                    $('#book_title').focus();
                    $('#book_title').on('input', searchTitleRelatedBooks);
                    $('#search_from_api').click(toggleSubmitButtonDisabling)
                }, 500);
            }
        })
    });
}

var toggleSubmitButtonDisabling = function () {
    if ((!$('#search_from_api').is(':checked')) || (!$("#book_title").val() == "")) {
        $(".save-form").attr('disabled', false)
    }
    else {
        $(".save-form").attr('disabled', true)
    }
}

var searchTitleRelatedBooks = function () {
    toggleSubmitButtonDisabling();
    var searched_books_titles;
    if ($('#search_from_api').is(':checked') && $(this).val().length >= 3) {
        $.getJSON('https://www.googleapis.com/books/v1/volumes?q=' + $(this).val(), function (response) {
            $.each(response.items, function (key, val) {
                if (!searched_books_titles)
                    searched_books_titles = []
                searched_books_titles.push(val.volumeInfo.title);
            });
        })
            .complete(function () {
                $('#book_title').autocomplete({
                    lookup: searched_books_titles,
                    onSelect: function (suggestion) {
                        searchGoogleBooksByTitle(suggestion.value)
                    }
                })
            })
    }
}

var searchGoogleBooksByTitle = function (title) {
    $(".fetching-info").show()
    $.ajax({
        url: '/books/get_by_title/' + title,
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function (searchedBook) {
            $(".fetching-info").hide()
            displaySearchedBookValues(searchedBook);
        }
    })
}

var displaySearchedBookValues = function (searchedBook) {
    var searchedBookJson = JSON.parse(searchedBook)
    $('#book_title').val(searchedBookJson.possible_book.title)
    $('#book_author').val(searchedBookJson.possible_book.author)
    $('#book_description').val(searchedBookJson.possible_book.description)
    $('#book_isbn').val(searchedBookJson.possible_book.isbn)
    $("#book_image").attr("src", searchedBookJson.image_link)
    $("#errors").text('')
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

