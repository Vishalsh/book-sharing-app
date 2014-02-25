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
                    $("#reset").click(reset)
                    $('#tags').tagsinput()
                    $('#book_title').focus();
                    $('#book_title').on('input', searchTitleRelatedBooks);
                    enableAutocomplete();
                }, 500);
            }
        })
    });
}

var searchTitleRelatedBooks = function () {

    var val = $(this).val().trim();
    val = val.replace(/\s+/g, '');

    if (val.length % 3 == 0 && val != '') {
        var searched_books_titles = [];
        $.ajax({
            url: 'https://www.googleapis.com/books/v1/volumes?q=' + $(this).val(),
            type: 'GET',
            crossDomain: true,
            dataType: 'json',
            success: function (searchedBooks) {
                $.each(searchedBooks.items, function (key, val) {
                    searched_books_titles.push(val.volumeInfo.title);
                });
                $('#book_title').autocomplete().setOptions({lookup: searched_books_titles});
            }
        })
    }
}

var enableAutocomplete = function () {
    $('#book_title').autocomplete({
        onSelect: function (suggestion) {
            searchGoogleBooksByTitle(suggestion.value)
        }
    })
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
        },

        error: function (error) {
            $(".fetching-info").hide()
            $(".alert-danger").text(error.responseText)
            $(".alert-danger").show();

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

var reset = function () {
    $(".form-control").val("")
    $("#book_image").attr("src", "/assets/book_image.png")
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

