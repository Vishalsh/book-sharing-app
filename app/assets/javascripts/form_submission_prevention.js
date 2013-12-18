var setupSearchBox = function(){
   $(".search-form").on('submit', function(event) {
       if ($("#search_box").val() == "") {
           event.preventDefault();
       }
   })
}

$(document).ready(setupSearchBox);
$(document).on('page:load', setupSearchBox);
