var getSelectedValue = function () {
    $($("#filter").find("li")).on('click', function (e) {

        var targetText = $(e.target).text()

        $('#selected_value').text(targetText)
        $('#search_box').attr('placeholder',  'Search Your Book By ' + targetText)
    })

}

$(document).ready(getSelectedValue);
