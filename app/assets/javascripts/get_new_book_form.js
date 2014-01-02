// var getNewBookForm = function () {

//     $("#add_new_book").on('click', function (e) {

//         $.ajax({

//             url: '/books/new',
//             type: 'GET',
//             crossDomain: true,
//             dataType: 'html'

//         }).success( function (data) {
//             $(data).modal('show');
//             console.log($('#search-button'));

//             $("#search-button").on('click', function (e) {

//                 $.ajax({
//                     url: '/books/get_by_isbn/:' + $('#book_isbn').val(),
//                     type: 'GET',
//                     crossDomain: true,
//                     dataType: 'html'
//                 }).success( function (book){
//                     $('#title').val('title')
//                     $('#author').val('author')
//                     $('#description').val('description')
//                 });


//             });
//         });

//     });
// }


// $(document).ready(getNewBookForm)
// $(document).on('page:load', getNewBookForm);
