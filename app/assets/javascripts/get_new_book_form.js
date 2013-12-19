var getNewBookForm = function () {

    $("#add_new_book").on('click', function (e) {

        $.ajax({

            url: '/books/new',
            type: 'GET',
            crossDomain: true,
            dataType: 'html'

        }).success( function (data) {
            $(data).modal('show');
        });

    });
}


$(document).ready(getNewBookForm)
$(document).on('page:load', getNewBookForm);
