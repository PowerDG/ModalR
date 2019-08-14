function passwordStyle(eleId) {
    if ($('#' + eleId).val() === '') $('#' + eleId).css("font-size", "inherit");
    else $('#' + eleId).css("font-size", "20px");
}

$("#OldPassword").bind("input propertychange change", function (event) {
    passwordStyle("OldPassword");
});

$("#NewPassword").bind("input propertychange change", function (event) {
    passwordStyle("NewPassword");
});

$("#ConfirmPassword").bind("input propertychange change", function (event) {
    passwordStyle("ConfirmPassword");
});
