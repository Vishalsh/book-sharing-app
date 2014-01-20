var toggleArrow = function() {
    $(".right-caret").click(function(e) {
        $(e.target).toggleClass("caret");
    })
}

$(document).ready(toggleArrow);