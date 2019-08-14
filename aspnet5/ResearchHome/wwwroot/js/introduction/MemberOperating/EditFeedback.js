function selectChangeEvent() {
    $('.layui-select-title input').on("change", function () {
        var providerVal = $("#provider").val();
        if (providerVal === "" || providerVal === "0") {
            var value = $('.layui-select-title input').val();
            $("#provider").append("<option value='0' selected>" + value + "</option>");
            selectChangeEvent();
            _form.render();
        }
    });
}

function loadSelectData() {
    var providers = $("#provider");
    if (isAdmin == "True") {
        $.post("/select/getmemberslist", function (data) {
            $.each(data, function (index, obj) {
                providers.append("<option value='" + obj.Id + "'>" + obj.Name + "</option>");
            })
            if (actionType == 0) {
                if (providerId > 0) {
                    providers.val(providerId);
                } else if (providerName != '') {
                    $("#provider").append("<option value='0' selected>" + providerName + "</option>");
                }
            } else {
                providers.val(currentUserId);
            }
            _form.render();
            selectChangeEvent();

            var dlList = document.getElementsByClassName("layui-anim layui-anim-upbit");
            if (dlList.length > 0) {
                dlList[0].style.height = "180px";
            }
        });
    } else {
        providers.append("<option value='" + currentUserId + "' selected>" + currentUserName + "</option>");
        $(providers).attr('disabled', 'disabled');
        _form.render();
    }
}

function save() {
    var feedback = {};
    feedback.memberId = $("#txtMemberId").val();
    feedback.content = $("#txtContent").val();
    feedback.providerId = $("#provider").val();
    feedback.Id = $("#txtFeedbackId").val();
    feedback.isCheck = $("#isCheck").val();
    feedback.code = $("#VerificationCode").val();
    if (currentUserId == 0) {
        feedback.providerName = $("#txtName").val();
    } else if (isAdmin == "True" && feedback.providerId == "0") {
        feedback.providerName = $("#provider option:selected").text();
    }
    if (checkDataVaild(feedback)) {
        $.post("/introduction/feedback/editfeedback", feedback, function (data) {
            parent.layer.msg(data.message, {
                icon: 6,
                shift: -1,
                time: 500,
                shade: 0.3
            }, function () {
                if (data.success) {
                    parent.layer.closeAll();
                    foowwLocalStorage.set("UID" + currentUserId + "-repeatedlySumbit", true, 7200000);
                } else {
                    showImage();
                }
            })
        });
    }
}

function checkDataVaild(feedback) {
    $("#error_providerText").css("display", feedback.providerName == "" ? "block" : "none");
    $("#error_providerSelect").css("display", (feedback.providerId == 0 || feedback.providerId == -1) && feedback.providerName == "" ? "block" : "none");
    $("#error_content").css("display", feedback.content == "" ? "block" : "none");
    $("#error_code").css("display", $("#isCheck").val() == "true" && $("#VerificationCode").val() == "" ? "block" : "none");
    return !(feedback.providerName == "" || ((feedback.providerId == 0 && feedback.providerName == "")
        || feedback.content == "" || ($("#isCheck").val() == "true" && $("#VerificationCode").val() == "")));
}

function onchangeEvent(e, errorId) {
    $("#" + errorId).css("display", $(e).val() === "" ? "block" : "none");
}

function showImage() {
    $.get("/Authorization/ShowCodeImage", function (data) {
        $("#codeImg").attr("src", "data:image/jpeg;base64," + data);
    });
}