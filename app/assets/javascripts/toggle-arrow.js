var toggleArrow = function () {
    $("body").click(function (e) {
        if ($(e.target).hasClass("right-caret")) {
            $(e.target).toggleClass("caret");
        }
        else {
            $(".right-caret").removeClass("caret");
        }

    })
}

$(document).ready(toggleArrow);