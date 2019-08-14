function passwordStyle(eleId) {
    if ($('#' + eleId).val() === '') $('#' + eleId).css("font-size", "inherit");
    else $('#' + eleId).css("font-size", "20px");
}

$("#Password").bind("input propertychange change", function (event) {
    passwordStyle("Password");
});

function showImage() {
    $.get("/Authorization/ShowCodeImage", function (data) {
        $("#codeImg").attr("src", "data:image/jpeg;base64," + data);
    });
}

$(document).keypress(function (event) {
    if (event.which === 13) {
        $("#btnSubmit").click();
    }
});